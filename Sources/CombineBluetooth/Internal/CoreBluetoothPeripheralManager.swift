import Combine
import CoreBluetooth

class CoreBluetoothPeripheralManager: NSObject {
    private var kvoDelegate: AnyCancellable?
    private let peripheralManager: CBPeripheralManager

    init(peripheralManager: CBPeripheralManager) {
        self.peripheralManager = peripheralManager
        super.init()
        restoreDelegation()
    }

    private var _state: CurrentValueSubject<CBManagerState, BluetoothError> = .init(.unknown)
    private var _stateRestoration: PassthroughSubject<StateRestorationEvent, BluetoothError> = .init()
    private var _advertisementPublisher: PassthroughSubject<Void, BluetoothError> = .init()

    private var _didAddService: PassthroughSubject<(service: CBService, result: Result<Void, Error>), Never> = .init()
    private var _didSubscribeToCharacteristic: PassthroughSubject<(central: CBCentral, characteristic: CBCharacteristic), Never> = .init()
    private var _didUnsubscribeFromCharacteristic: PassthroughSubject<(central: CBCentral, characteristic: CBCharacteristic), Never> = .init()
    private var _didReceiveReadRequest: PassthroughSubject<CBATTRequest, Never> = .init()
    private var _didReceiveWriteRequests: PassthroughSubject<[CBATTRequest], Never> = .init()
    private var _becameReadyForWriteWithoutResponse: PassthroughSubject<Void, Never> = .init()
    private let _didOpenChannel = PassthroughSubject<Result<L2CAPChannel, Error>, Never>()
    private var _didPublishL2CAPChannel = PassthroughSubject<(PSM: CBL2CAPPSM, result: Result<Void, Error>), Never>()
    private var _didUnpublishL2CAPChannel = PassthroughSubject<(PSM: CBL2CAPPSM, result: Result<Void, Error>), Never>()

    func restoreDelegation() {
        _state = .init(peripheralManager.state)
        _stateRestoration = .init()
        _advertisementPublisher = .init()
        peripheralManager.delegate = self
        kvoDelegate = peripheralManager.publisher(for: \.delegate).sink { [weak self] value in
            guard let self = self else { return }
            guard value !== self else { return }

            self._state.send(completion: .failure(.noLongerDelegate))
            self._stateRestoration.send(completion: .failure(.noLongerDelegate))
            self._advertisementPublisher.send(completion: .failure(.noLongerDelegate))
            self.kvoDelegate = nil
        }
    }
}

extension CoreBluetoothPeripheralManager: PeripheralManager {
    var isAdvertising: AnyPublisher<Bool, Never> {
        peripheralManager
            .publisher(for: \.isAdvertising)
            .prepend(peripheralManager.isAdvertising)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    var isReadyAgainForWriteWithoutResponse: AnyPublisher<Void, Never> {
        return _becameReadyForWriteWithoutResponse.eraseToAnyPublisher()
    }
    var state: AnyPublisher<CBManagerState, BluetoothError> { _state.eraseToAnyPublisher() }
    var stateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError> { _stateRestoration.eraseToAnyPublisher() }
    var characteristicsSubscriptions: AnyPublisher<(subscribed: Bool, central: BluetoothCentral, characteristic: BluetoothCharacteristic), Never> {
        Publishers.Merge(
            _didSubscribeToCharacteristic.map {
                (subscribed: true, central: $0.central, characteristic: CoreBluetoothCharacteristic(characteristic: $0.characteristic))
            },

            _didUnsubscribeFromCharacteristic.map {
                (subscribed: false, central: $0.central, characteristic: CoreBluetoothCharacteristic(characteristic: $0.characteristic))
            }
        ).eraseToAnyPublisher()
    }
    var requests: AnyPublisher<(type: ATTRequestType, requests: [ATTRequest]), Never> {
        Publishers.Merge(
            _didReceiveReadRequest.map {
                (type: .read, requests: [CoreBluetoothATTRequest(attRequest: $0)])
            },

            _didReceiveWriteRequests.map {
                (type: .write, requests: $0.map(CoreBluetoothATTRequest.init))
            }
        ).eraseToAnyPublisher()
    }

    func startAdvertising() -> AnyPublisher<Void, BluetoothError> {
        _startAdvertising(nil)
    }
    func startAdvertising(advertisementData: [String : Any]) -> AnyPublisher<Void, BluetoothError> {
        _startAdvertising(advertisementData)
    }
    private func _startAdvertising(_ advertisementData: [String : Any]?) -> AnyPublisher<Void, BluetoothError> {
        _advertisementPublisher = .init()
        let pm = self.peripheralManager
        return _advertisementPublisher
            .handleEvents(
                receiveCancel: { pm.stopAdvertising() },
                receiveRequest: { demand in
                    guard demand > .none else { return }
                    pm.startAdvertising(advertisementData)
                }
            )
            .eraseToAnyPublisher()
    }

    func setDesiredConnectionLatency(_ latency: CBPeripheralManagerConnectionLatency, for central: BluetoothCentral) -> Result<Void, BluetoothError> {
        guard let coreBluetoothCentral = central as? CBCentral else { return .failure(BluetoothError.unknownWrapperType) }
        peripheralManager.setDesiredConnectionLatency(latency, for: coreBluetoothCentral)
        return .success(())
    }

    func add(_ service: BluetoothService) -> AnyPublisher<BluetoothService, BluetoothError> {
        guard let coreBluetoothService = service as? CoreBluetoothService,
            let mutableService = coreBluetoothService.service as? CBMutableService
        else { return Fail(error: .unknownWrapperType).eraseToAnyPublisher() }

        let pm = peripheralManager
        let lock = NSRecursiveLock()
        var added = false

        return _didAddService
            .filter { $0.service.id == coreBluetoothService.id }
            .tryMap { try $0.result.get() }
            .map { _ in service }
            .mapError { BluetoothError.onAddService(service: service, details: $0) }
            .handleEvents(
                receiveRequest: { demand in
                    guard demand > .none else { return }
                    lock.lock()
                    defer { lock.unlock() }
                    guard !added else { return }
                    added = true
                    pm.add(mutableService)
                }

            )
            .eraseToAnyPublisher()
    }

    func remove(_ service: BluetoothService) -> Result<BluetoothService, BluetoothError> {
        guard let coreBluetoothService = service as? CoreBluetoothService,
            let mutableService = coreBluetoothService.service as? CBMutableService
            else { return .failure(BluetoothError.unknownWrapperType) }

        peripheralManager.remove(mutableService)
        return .success(CoreBluetoothService(service: mutableService))
    }

    func removeAllServices() {
        peripheralManager.removeAllServices()
    }

    func respond(to request: ATTRequest, withResult result: CBATTError.Code) -> Result<Void, BluetoothError> {
        guard let coreBluetoothAttRequest = request as? CoreBluetoothATTRequest else { return .failure(.unknownWrapperType) }
        peripheralManager.respond(to: coreBluetoothAttRequest.attRequest, withResult: result)
        return .success(())
    }
    
    func updateValue(_ value: Data, for characteristic: BluetoothCharacteristic, onSubscribedCentrals centrals: [BluetoothCentral]?) -> Result<Bool, BluetoothError> {
        guard let coreBluetoothCharacteristic = characteristic as? CoreBluetoothCharacteristic,
            let mutableCharacteristic = coreBluetoothCharacteristic.characteristic as? CBMutableCharacteristic else { return .failure(.unknownWrapperType) }

        let coreBluetothCentrals = centrals?.compactMap { $0 as? CBCentral }
        guard centrals?.count == coreBluetothCentrals?.count else { return .failure(.unknownWrapperType) }

        return .success(peripheralManager.updateValue(value, for: mutableCharacteristic, onSubscribedCentrals: coreBluetothCentrals))
    }

    func publishL2CAPChannel(withEncryption encryptionRequired: Bool) -> AnyPublisher<CBL2CAPPSM, BluetoothError> {
        let pm = peripheralManager

        return _didPublishL2CAPChannel
            .tryMap {
                let psm = $0.PSM
                switch $0.result {
                case .success:
                    return psm
                case let .failure(error):
                    throw BluetoothError.onPublishChannel(PSM: psm, details: error)
                }
            }
            .mapError { $0 as! BluetoothError }
            .handleEvents(
                receiveRequest: { demand in
                    guard demand > .none else { return }
                    pm.publishL2CAPChannel(withEncryption: encryptionRequired)
                }
            )
            .eraseToAnyPublisher()
    }

    func unpublishL2CAPChannel(_ PSM: CBL2CAPPSM) -> AnyPublisher<CBL2CAPPSM, BluetoothError> {
        let pm = peripheralManager

        return _didUnpublishL2CAPChannel
            .filter { $0.PSM == PSM }
            .tryMap {
                let psm = $0.PSM
                switch $0.result {
                case .success:
                    return psm
                case let .failure(error):
                    throw BluetoothError.onPublishChannel(PSM: psm, details: error)
                }
            }
            .mapError { $0 as! BluetoothError }
            .handleEvents(
                receiveRequest: { demand in
                    guard demand > .none else { return }
                    pm.unpublishL2CAPChannel(PSM)
                }
            )
            .eraseToAnyPublisher()
    }
}

extension CoreBluetoothPeripheralManager: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        _state.send(peripheral.state)
    }

    func peripheralManager(_ peripheral: CBPeripheralManager, willRestoreState dict: [String : Any]) {
        _stateRestoration.send(.willRestoreState(dict))
    }

    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if peripheral.isAdvertising {
            _advertisementPublisher.send()
        } else {
            _advertisementPublisher.send(completion: .failure(.failOnStartAdvertising(error: error)))
        }
    }

    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        _didAddService.send(
            (service: service, result: error.map(Result.failure) ?? .success(()))
        )
    }

    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        _didSubscribeToCharacteristic.send((central: central, characteristic: characteristic))
    }

    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFrom characteristic: CBCharacteristic) {
        _didUnsubscribeFromCharacteristic.send((central: central, characteristic: characteristic))
    }

    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        _didReceiveReadRequest.send(request)
    }

    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        _didReceiveWriteRequests.send(requests)
    }

    func peripheralManagerIsReady(toUpdateSubscribers peripheral: CBPeripheralManager) {
        _becameReadyForWriteWithoutResponse.send(())
    }

    func peripheralManager(_ peripheral: CBPeripheralManager, didOpen channel: CBL2CAPChannel?, error: Error?) {
        _didOpenChannel.send(
            error.map(Result.failure)
                ?? channel.map(CoreBluetoothL2CAPChannel.init).map(Result.success)
                ?? Result.failure(NSError(
                    domain: "peripheral(_ peripheral: CBPeripheral, didOpen channel: CBL2CAPChannel?, error: Error?) with both nil",
                    code: -1,
                    userInfo: nil
                ))
        )
    }

    func peripheralManager(_ peripheral: CBPeripheralManager, didPublishL2CAPChannel PSM: CBL2CAPPSM, error: Error?) {
        _didPublishL2CAPChannel.send((PSM: PSM, result: error.map(Result.failure) ?? .success(())))
    }

    func peripheralManager(_ peripheral: CBPeripheralManager, didUnpublishL2CAPChannel PSM: CBL2CAPPSM, error: Error?) {
        _didUnpublishL2CAPChannel.send((PSM: PSM, result: error.map(Result.failure) ?? .success(())))
    }
}

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
    var state: AnyPublisher<CBManagerState, BluetoothError> { _state.eraseToAnyPublisher() }
    var stateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError> { _stateRestoration.eraseToAnyPublisher() }
    func startAdvertising() -> AnyPublisher<Void, BluetoothError> {
        _startAdvertising(nil)
    }
    func startAdvertising(_ advertisementData: [String : Any]) -> AnyPublisher<Void, BluetoothError> {
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

    func setDesiredConnectionLatency(_ latency: CBPeripheralManagerConnectionLatency, for central: CBCentral) {
        peripheralManager.setDesiredConnectionLatency(latency, for: central)
    }

    func add(_ service: BluetoothService) -> Deferred<Future<BluetoothService, BluetoothError>> {
        guard let coreBluetoothService = service as? CoreBluetoothService else { return .failure(BluetoothError.unknownWrapperType) }
        let mutableService = CBMutableService(type: coreBluetoothService.id, primary: coreBluetoothService.isPrimary)
        mutableService.characteristics = coreBluetoothService.characteristics?.compactMap { ($0 as? CoreBluetoothCharacteristic)?.characteristic }
        mutableService.includedServices = coreBluetoothService.includedServices?.compactMap { ($0 as? CoreBluetoothService)?.service }
        let pm = peripheralManager

        return _didAddService
            .filter { $0.service.id == coreBluetoothService.id }
            .tryMap { try $0.result.get() }
            .map { _ in service }
            .mapError { BluetoothError.onAddService(service: service, details: $0) }
            .handleEvents(
                receiveRequest: { demand in
                    guard demand > .none else { return }
                    pm.add(mutableService)
                }
            )
            .first()
            .asDeferredFuture()
    }

    func remove(_ service: BluetoothService) -> Result<BluetoothService, BluetoothError> {
        guard let coreBluetoothService = service as? CoreBluetoothService else { return .failure(BluetoothError.unknownWrapperType) }
        let mutableService = CBMutableService(type: coreBluetoothService.id, primary: coreBluetoothService.isPrimary)
        mutableService.characteristics = coreBluetoothService.characteristics?.compactMap { ($0 as? CoreBluetoothCharacteristic)?.characteristic }
        mutableService.includedServices = coreBluetoothService.includedServices?.compactMap { ($0 as? CoreBluetoothService)?.service }
        peripheralManager.remove(mutableService)
        return .success(CoreBluetoothService(service: mutableService))
    }

    func removeAllServices() {
        peripheralManager.removeAllServices()
    }

    // TODO: WIP
    // func respond(to request: CBATTRequest, withResult result: CBATTError.Code) { }
    // func updateValue(_ value: Data, for characteristic: CBMutableCharacteristic, onSubscribedCentrals centrals: [CBCentral]?) -> Bool { }
    // func publishL2CAPChannel(withEncryption encryptionRequired: Bool) { }
    // func unpublishL2CAPChannel(_ PSM: CBL2CAPPSM) { }
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

    // TODO: WIP
    // func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) { }
    // func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFrom characteristic: CBCharacteristic) { }
    // func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) { }
    // func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) { }
    // func peripheralManagerIsReady(toUpdateSubscribers peripheral: CBPeripheralManager) { }
    // func peripheralManager(_ peripheral: CBPeripheralManager, didPublishL2CAPChannel PSM: CBL2CAPPSM, error: Error?) { }
    // func peripheralManager(_ peripheral: CBPeripheralManager, didUnpublishL2CAPChannel PSM: CBL2CAPPSM, error: Error?) { }
    // func peripheralManager(_ peripheral: CBPeripheralManager, didOpen channel: CBL2CAPChannel?, error: Error?) { }
}

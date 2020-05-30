import Combine
import CoreBluetooth

class CoreBluetoothCentralManager: NSObject {
    private var kvoDelegate: AnyCancellable?
    private let centralManager: CBCentralManager

    init(centralManager: CBCentralManager) {
        self.centralManager = centralManager
        super.init()
        restoreDelegation()
    }

    private var _state: CurrentValueSubject<CBManagerState, BluetoothError> = .init(.unknown)
    private var _stateRestoration: PassthroughSubject<StateRestorationEvent, BluetoothError> = .init()
    private var _scanPublisher: PassthroughSubject<AdvertisingPeripheral, BluetoothError> = .init()

    private var _didConnectPeripheral: PassthroughSubject<CBPeripheral, Never> = .init()
    private var _didFailToConnectPeripheral: PassthroughSubject<(peripheral: CBPeripheral, error: Error?), Never> = .init()
    private var _didDisconnectPeripheral: PassthroughSubject<(peripheral: CBPeripheral, error: Error?), Never> = .init()

    func restoreDelegation() {
        _state = .init(centralManager.state)
        _stateRestoration = .init()
        _scanPublisher = .init()
        centralManager.delegate = self
        kvoDelegate = centralManager.publisher(for: \.delegate).sink { [weak self] value in
            guard let self = self else { return }
            guard value !== self else { return }

            self._state.send(completion: .failure(.noLongerDelegate))
            self._stateRestoration.send(completion: .failure(.noLongerDelegate))
            self._scanPublisher.send(completion: .failure(.noLongerDelegate))
            self.kvoDelegate = nil
        }
    }
}

extension CoreBluetoothCentralManager: CentralManager {
    var isScanning: AnyPublisher<Bool, Never> {
        centralManager
            .publisher(for: \.isScanning)
            .prepend(centralManager.isScanning)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    var state: AnyPublisher<CBManagerState, BluetoothError> { _state.eraseToAnyPublisher() }
    var stateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError> { _stateRestoration.eraseToAnyPublisher() }
    func scanForPeripherals() -> AnyPublisher<AdvertisingPeripheral, BluetoothError> {
        _scanForPeripherals(withServices: nil, options: nil)
    }
    func scanForPeripherals(withServices serviceUUIDs: [CBUUID]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError> {
        _scanForPeripherals(withServices: serviceUUIDs, options: nil)
    }
    func scanForPeripherals(options: [String : Any]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError> {
        _scanForPeripherals(withServices: nil, options: options)
    }
    func scanForPeripherals(withServices serviceUUIDs: [CBUUID], options: [String : Any]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError> {
        _scanForPeripherals(withServices: serviceUUIDs, options: options)
    }

    private func _scanForPeripherals(withServices serviceUUIDs: [CBUUID]?, options: [String: Any]?) -> AnyPublisher<AdvertisingPeripheral, BluetoothError> {
        _scanPublisher = .init()
        let cm = self.centralManager
        return _scanPublisher
            .handleEvents(
                receiveCancel: { cm.stopScan() },
                receiveRequest: { demand in
                    guard demand > .none else { return }
                    cm.scanForPeripherals(withServices: serviceUUIDs, options: options)
                }
            )
            .eraseToAnyPublisher()
    }

    var peripheralConnection: AnyPublisher<PeripheralConnectionEvent, Never> {
        Publishers.Merge3(
            _didConnectPeripheral
                .map(CoreBluetoothPeripheral.init)
                .map(PeripheralConnectionEvent.didConnect),
            _didDisconnectPeripheral
                .map { PeripheralConnectionEvent.didDisconnect(peripheral: CoreBluetoothPeripheral(peripheral: $0.peripheral), error: $0.error) },
            _didFailToConnectPeripheral
                .map { PeripheralConnectionEvent.didFailToConnect(peripheral: CoreBluetoothPeripheral(peripheral: $0.peripheral), error: $0.error) }
        )
        .eraseToAnyPublisher()
    }

    func connect(_ peripheral: BluetoothPeripheral) -> AnyPublisher<BluetoothPeripheral, BluetoothError> {
        _connect(peripheral, options: nil)
    }

    func connect(_ peripheral: BluetoothPeripheral, options: [String : Any]) -> AnyPublisher<BluetoothPeripheral, BluetoothError> {
        _connect(peripheral, options: options)
    }

    private func _connect(_ peripheral: BluetoothPeripheral, options: [String : Any]?) -> AnyPublisher<BluetoothPeripheral, BluetoothError> {
        guard let coreBluetoothPeripheral = peripheral as? CoreBluetoothPeripheral else { return Fail(error: BluetoothError.unknownWrapperType).eraseToAnyPublisher() }
        let cm = centralManager
        return Publishers.Merge3(
            _didConnectPeripheral
                .filter { $0.identifier == coreBluetoothPeripheral.peripheral.identifier }
                .map(CoreBluetoothPeripheral.init)
                .mapError { never -> BluetoothError in },
            _didDisconnectPeripheral
                .filter { $0.peripheral.identifier == coreBluetoothPeripheral.peripheral.identifier }
                .tryMap { disconnection -> BluetoothPeripheral in
                    throw BluetoothError.lostConnection(peripheral: CoreBluetoothPeripheral(peripheral: disconnection.peripheral), error: disconnection.error)
                }
                .mapError { $0 as! BluetoothError },
            _didFailToConnectPeripheral
                .filter { $0.peripheral.identifier == coreBluetoothPeripheral.peripheral.identifier }
                .tryMap { disconnection -> BluetoothPeripheral in
                    throw BluetoothError.failOnConnect(peripheral: CoreBluetoothPeripheral(peripheral: disconnection.peripheral), error: disconnection.error)
                }
                .mapError { $0 as! BluetoothError }
        )
        .handleEvents(
            receiveSubscription: { _ in
                cm.connect(coreBluetoothPeripheral.peripheral, options: options)
            },
            receiveCancel: {
                cm.cancelPeripheralConnection(coreBluetoothPeripheral.peripheral)
            }
        )
        .eraseToAnyPublisher()
    }

    func retrievePeripherals(withIdentifiers identifiers: [UUID]) -> [BluetoothPeripheral] {
        centralManager.retrievePeripherals(withIdentifiers: identifiers).map(CoreBluetoothPeripheral.init)
    }

    func retrieveConnectedPeripherals(withServices serviceUUIDs: [CBUUID]) -> [BluetoothPeripheral] {
        centralManager.retrieveConnectedPeripherals(withServices: serviceUUIDs).map(CoreBluetoothPeripheral.init)
    }
}

extension CoreBluetoothCentralManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        _state.send(central.state)
    }

    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        _stateRestoration.send(.willRestoreState(dict))
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        _scanPublisher.send(
            CoreBluetoothAdvertisingPeripheral(
                advertisementData: advertisementData,
                rssi: RSSI,
                peripheral: CoreBluetoothPeripheral(peripheral: peripheral)
            )
        )
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        _didConnectPeripheral.send(peripheral)
    }

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        _didFailToConnectPeripheral.send((peripheral: peripheral, error: error))
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        _didDisconnectPeripheral.send((peripheral: peripheral, error: error))
    }
}

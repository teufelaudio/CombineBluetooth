import Combine
import CoreBluetooth

public protocol CentralManager {
    var isScanning: AnyPublisher<Bool, Never> { get }
    var state: AnyPublisher<CBManagerState, BluetoothError> { get }
    var stateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError> { get }
    var peripheralConnection: AnyPublisher<PeripheralConnectionEvent, Never> { get }
    func scanForPeripherals() -> AnyPublisher<AdvertisingPeripheral, BluetoothError>
    func scanForPeripherals(withServices serviceUUIDs: [CBUUID]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError>
    func scanForPeripherals(withServices serviceUUIDs: [CBUUID], options: [String: Any]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError>
    func scanForPeripherals(options: [String: Any]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError>
    func retrievePeripherals(withIdentifiers identifiers: [UUID]) -> [CBPeripheral]
    func retrieveConnectedPeripherals(withServices serviceUUIDs: [CBUUID]) -> [CBPeripheral]
    func connect(_ peripheral: BluetoothPeripheral) -> AnyPublisher<BluetoothPeripheral, BluetoothError>
    func connect(_ peripheral: BluetoothPeripheral, options: [String : Any]) -> AnyPublisher<BluetoothPeripheral, BluetoothError>
}

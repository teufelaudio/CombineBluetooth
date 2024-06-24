import Combine
import CoreBluetooth

// sourcery: AutoMockable
public protocol CentralManager: BluetoothManager {
    var isScanning: AnyPublisher<Bool, Never> { get }
    var peripheralConnection: AnyPublisher<PeripheralConnectionEvent, Never> { get }
    func scanForPeripherals() -> AnyPublisher<AdvertisingPeripheral, BluetoothError>
    func scanForPeripherals(withServices serviceUUIDs: [CBUUID]?) -> AnyPublisher<AdvertisingPeripheral, BluetoothError>
    func scanForPeripherals(withServices serviceUUIDs: [CBUUID]?, options: [String: Any]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError>
    func scanForPeripherals(options: [String: Any]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError>
    func retrievePeripherals(withIdentifiers identifiers: [UUID]) -> [BluetoothPeripheral]
    func retrieveConnectedPeripherals(withServices serviceUUIDs: [CBUUID]) -> [BluetoothPeripheral]
    func connect(_ peripheral: BluetoothPeripheral) -> AnyPublisher<BluetoothPeripheral, BluetoothError>
    func connect(_ peripheral: BluetoothPeripheral, options: [String : Any]) -> AnyPublisher<BluetoothPeripheral, BluetoothError>
    func peripheral(for uuid: UUID) -> BluetoothPeripheral?
    
    // TODO: Nice to have, but complicate to handle single delegate (subscribing again with different options should end prior observations, which can
    //       be a bit unexpected).
    // - (void)registerForConnectionEventsWithOptions:(nullable NSDictionary<CBConnectionEventMatchingOption, id> *)options NS_AVAILABLE_IOS(13_0);
}

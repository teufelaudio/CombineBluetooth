import Combine
import CoreBluetooth

public protocol PeripheralManager {
    var isAdvertising: AnyPublisher<Bool, Never> { get }
    var state: AnyPublisher<CBManagerState, BluetoothError> { get }
    var stateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError> { get }
    func startAdvertising() -> AnyPublisher<Void, BluetoothError>
    func startAdvertising(_ advertisementData: [String: Any]) -> AnyPublisher<Void, BluetoothError>
    func setDesiredConnectionLatency(_ latency: CBPeripheralManagerConnectionLatency, for central: CBCentral)
    func add(_ service: BluetoothService) -> Deferred<Future<BluetoothService, BluetoothError>>
    func remove(_ service: BluetoothService) -> Result<BluetoothService, BluetoothError>
    func removeAllServices()
}

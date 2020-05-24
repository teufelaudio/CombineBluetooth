import Combine
import CoreBluetooth

public protocol BluetoothManager {
    var state: AnyPublisher<CBManagerState, BluetoothError> { get }
    var stateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError> { get }
}

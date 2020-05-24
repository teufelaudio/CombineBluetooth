import Combine
import CoreBluetooth

// sourcery: AutoMockable
public protocol BluetoothManager {
    var state: AnyPublisher<CBManagerState, BluetoothError> { get }
    var stateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError> { get }
}

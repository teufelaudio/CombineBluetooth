import Foundation

// sourcery: AutoMockable
public protocol ATTRequest {
    var central: BluetoothCentral { get }
    var characteristic: BluetoothCharacteristic { get }
    var offset: Int { get }
    var value: Data? { get }
}

import Foundation

// sourcery: AutoMockable
public protocol AdvertisingPeripheral {
    var advertisementData: [String: Any] { get }
    var rssi: NSNumber { get }
    var peripheral: BluetoothPeripheral { get }
}

extension AdvertisingPeripheral {
    var id: UUID { peripheral.id }
}

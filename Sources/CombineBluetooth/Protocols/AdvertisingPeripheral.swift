import Foundation

public protocol AdvertisingPeripheral {
    var advertisementData: [String: Any] { get }
    var rssi: NSNumber { get }
    var peripheral: BluetoothPeripheral { get }
}

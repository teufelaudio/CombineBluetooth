import Foundation

struct CoreBluetoothAdvertisingPeripheral {
    let advertisementData: [String: Any]
    let rssi: NSNumber
    let peripheral: BluetoothPeripheral
}

extension CoreBluetoothAdvertisingPeripheral: AdvertisingPeripheral { }

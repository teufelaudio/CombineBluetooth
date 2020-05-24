import Foundation

struct CoreBluetoothAdvertisingPeripheral: Identifiable {
    var id: UUID { peripheral.id }
    let advertisementData: [String: Any]
    let rssi: NSNumber
    let peripheral: BluetoothPeripheral
}

extension CoreBluetoothAdvertisingPeripheral: AdvertisingPeripheral { }

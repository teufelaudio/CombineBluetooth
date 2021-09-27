import Combine
import CoreBluetooth

struct CoreBluetoothCharacteristic: Identifiable {
    var id: CBUUID { characteristic.id }
    let characteristic: CBCharacteristic

    init(characteristic: CBCharacteristic) {
        self.characteristic = characteristic
    }
}

extension CoreBluetoothCharacteristic: BluetoothCharacteristic {
    #if swift(>=5.5) && !os(macOS)
    var service: BluetoothService? { characteristic.service.map(CoreBluetoothService.init) }
    #else
    var service: BluetoothService? { CoreBluetoothService(service: characteristic.service) }
    #endif
    var properties: CBCharacteristicProperties { characteristic.properties }
    var value: Data? { characteristic.value }
    var descriptors: [BluetoothDescriptor]? { characteristic.descriptors?.map(CoreBluetoothDescriptor.init) }
    var isNotifying: Bool { characteristic.isNotifying }
    var permissions: CBAttributePermissions? { (characteristic as? CBMutableCharacteristic)?.permissions }
    var subscribedCentrals: [BluetoothCentral]? { (characteristic as? CBMutableCharacteristic)?.subscribedCentrals }
}

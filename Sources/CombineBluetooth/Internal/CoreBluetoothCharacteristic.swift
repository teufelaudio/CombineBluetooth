import Combine
import CoreBluetooth

struct CoreBluetoothCharacteristic {
    let characteristic: CBCharacteristic

    init(characteristic: CBCharacteristic) {
        self.characteristic = characteristic
    }
}

extension CoreBluetoothCharacteristic: BluetoothCharacteristic {
    var service: BluetoothService { CoreBluetoothService(service: characteristic.service) }
    var properties: CBCharacteristicProperties { characteristic.properties }
    var value: Data? { characteristic.value }
    var descriptors: [CBDescriptor]? { characteristic.descriptors }
    var isNotifying: Bool { characteristic.isNotifying }
}

import Combine
import CoreBluetooth

struct CoreBluetoothDescriptor: Identifiable {
    var id: CBUUID { descriptor.id }
    let descriptor: CBDescriptor

    init(descriptor: CBDescriptor) {
        self.descriptor = descriptor
    }
}

extension CoreBluetoothDescriptor: BluetoothDescriptor {
    var characteristic: BluetoothCharacteristic? { descriptor.characteristic.map(CoreBluetoothCharacteristic.init) }
    var value: Any? { descriptor.value }
}

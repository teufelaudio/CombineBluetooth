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
    #if swift(>=5.5) && !os(macOS)
    var characteristic: BluetoothCharacteristic? { descriptor.characteristic.map(CoreBluetoothCharacteristic.init) }
    #else
    var characteristic: BluetoothCharacteristic? { CoreBluetoothCharacteristic(characteristic: descriptor.characteristic) }
    #endif
    var value: Any? { descriptor.value }
}

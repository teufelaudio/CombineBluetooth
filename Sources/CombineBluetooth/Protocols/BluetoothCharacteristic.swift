import CoreBluetooth

public protocol BluetoothCharacteristic {
    var id: CBUUID { get }
    var service: BluetoothService { get }
    var properties: CBCharacteristicProperties { get }
    var value: Data? { get }
    var descriptors: [CBDescriptor]? { get }
    var isNotifying: Bool { get }
}

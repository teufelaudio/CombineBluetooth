import CoreBluetooth

// sourcery: AutoMockable
public protocol BluetoothCharacteristic {
    var id: CBUUID { get }
    var service: BluetoothService? { get }
    var properties: CBCharacteristicProperties { get }
    var value: Data? { get }
    var descriptors: [BluetoothDescriptor]? { get }
    var isNotifying: Bool { get }
    var permissions: CBAttributePermissions? { get }
    var subscribedCentrals: [BluetoothCentral]? { get }
}

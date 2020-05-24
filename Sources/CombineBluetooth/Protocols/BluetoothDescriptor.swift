import CoreBluetooth
public protocol BluetoothDescriptor {
    var id: CBUUID { get }
    var characteristic: BluetoothCharacteristic { get }
    var value: Any? { get }
}

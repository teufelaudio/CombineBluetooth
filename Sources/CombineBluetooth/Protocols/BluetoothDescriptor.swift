public protocol BluetoothDescriptor {
    var characteristic: BluetoothCharacteristic { get }
    var value: Any? { get }
}

public protocol BluetoothService {
    var peripheral: BluetoothPeripheral { get }
    var isPrimary: Bool { get }
    var includedServices: [BluetoothService]? { get }
    var characteristics: [BluetoothCharacteristic]? { get }
}

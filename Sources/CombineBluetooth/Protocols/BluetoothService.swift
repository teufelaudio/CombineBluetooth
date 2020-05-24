import CoreBluetooth
public protocol BluetoothService {
    var id: CBUUID { get }
    var peripheral: BluetoothPeripheral { get }
    var isPrimary: Bool { get }
    var includedServices: [BluetoothService]? { get }
    var characteristics: [BluetoothCharacteristic]? { get }
}

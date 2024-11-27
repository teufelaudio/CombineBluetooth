import CoreBluetooth

// sourcery: AutoMockable
public protocol BluetoothService {
    var id: CBUUID { get }
    var peripheral: UUID? { get }
    var isPrimary: Bool { get }
    var includedServices: [BluetoothService]? { get }
    var characteristics: [BluetoothCharacteristic]? { get }
    
    init(service: CBService)
}

import CoreBluetooth

extension CBCentralManager {
    public var combine: CentralManager {
        CoreBluetoothCentralManager(centralManager: self)
    }
}

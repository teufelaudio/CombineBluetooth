import CoreBluetooth

extension CBCentralManager {
    public var combine: any CentralManager {
        // Disable the skip of central manager delegate observation as we know the central manager is an instance of CBCentralManager.
        CoreBluetoothCentralManager(centralManager: self, skipCentralManagerDelegateObservation: false)
    }
}

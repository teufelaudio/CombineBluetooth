import CoreBluetooth

extension CBCentralManager {
    /// Returns an implementation of CentralManager, which observes it's CBCentralManager's delegate for changes.
    /// In case the delegate gets changed to something other than this CentralManager implementation it'll end
    /// publishers with a failure.
    public var combine: any CentralManager {
        CoreBluetoothCentralManager(centralManager: self)
    }
    
    /// Returns an implementation of CentralManager, which *does not* observe it's CBCentralManager's delegate for changes.
    /// In case of change of the delegate, publishers will not end with a failure.
    public var combineWithoutDelegateObservation: any CentralManager {
        CoreBluetoothCentralManager(centralManager: self, skipDelegateObservation: true)
    }
}

public enum PeripheralConnectionEvent {
    case didConnect(peripheral: BluetoothPeripheral)
    case didFailToConnect(peripheral: BluetoothPeripheral, error: Error?)
    case didDisconnect(peripheral: BluetoothPeripheral, error: Error?)

    public var peripheral: BluetoothPeripheral {
        switch self {
        case let .didConnect(peripheral),
             let .didFailToConnect(peripheral, _),
             let .didDisconnect(peripheral, _):
            return peripheral
        }
    }
}

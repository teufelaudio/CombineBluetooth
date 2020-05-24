import Foundation

public protocol BluetoothCentral: BluetoothPeer {
    var maximumUpdateValueLength: Int { get }
}

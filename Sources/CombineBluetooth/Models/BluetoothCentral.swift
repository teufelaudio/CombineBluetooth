import Foundation

// sourcery: AutoMockable
public protocol BluetoothCentral: BluetoothPeer {
    var maximumUpdateValueLength: Int { get }
}

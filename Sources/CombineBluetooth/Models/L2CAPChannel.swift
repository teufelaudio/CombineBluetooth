import CoreBluetooth

// sourcery: AutoMockable
public protocol L2CAPChannel {
    var peer: BluetoothPeer { get }
    var inputStream: InputStream { get }
    var outputStream: OutputStream { get }
    var psm: CBL2CAPPSM { get }
}

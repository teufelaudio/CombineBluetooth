import CoreBluetooth

struct CoreBluetoothL2CAPChannel: L2CAPChannel {
    var peer: BluetoothPeer { channel.peer }
    var inputStream: InputStream { channel.inputStream }
    var outputStream: OutputStream { channel.outputStream }
    var psm: CBL2CAPPSM { channel.psm }

    let channel: CBL2CAPChannel
    init(channel: CBL2CAPChannel) {
        self.channel = channel
    }
}

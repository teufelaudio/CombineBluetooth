import CoreBluetooth

struct CoreBluetoothATTRequest: ATTRequest {
    let attRequest: CBATTRequest
    var central: BluetoothCentral { attRequest.central }
    var characteristic: BluetoothCharacteristic { CoreBluetoothCharacteristic(characteristic: attRequest.characteristic) }
    var offset: Int { attRequest.offset }
    var value: Data? { attRequest.value }
    
    init(attRequest: CBATTRequest) {
        self.attRequest = attRequest
    }
}

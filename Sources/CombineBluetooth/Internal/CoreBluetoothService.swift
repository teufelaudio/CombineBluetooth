import CoreBluetooth
import Combine

struct CoreBluetoothService {
    let service: CBService

    init(service: CBService) {
        self.service = service
    }
}

extension CoreBluetoothService: BluetoothService {
    var peripheral: BluetoothPeripheral { CoreBluetoothPeripheral(peripheral: service.peripheral) }
    var isPrimary: Bool { service.isPrimary }
    var includedServices: [BluetoothService]? { service.includedServices?.map(CoreBluetoothService.init) }
    var characteristics: [BluetoothCharacteristic]? { service.characteristics?.map(CoreBluetoothCharacteristic.init) }
}

import CoreBluetooth
import Combine

struct CoreBluetoothService: Identifiable {
    var id: CBUUID { service.id }
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

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
    #if swift(>=5.5) && !os(macOS)
    var peripheral: UUID? { service.peripheral?.identifier }
    #else
    var peripheral: UUID? { service.peripheral.identifier }
    #endif
    var isPrimary: Bool { service.isPrimary }
    var includedServices: [BluetoothService]? { service.includedServices?.map(CoreBluetoothService.init) }
    var characteristics: [BluetoothCharacteristic]? { service.characteristics?.map(CoreBluetoothCharacteristic.init) }
}

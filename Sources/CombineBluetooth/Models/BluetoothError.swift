import CoreBluetooth

public enum BluetoothError: Error {
    case noLongerDelegate
    case unknownWrapperType
    case failOnConnect(peripheral: BluetoothPeripheral, error: Error?)
    case lostConnection(peripheral: BluetoothPeripheral, error: Error?)
    case onReadRSSI(peripheral: BluetoothPeripheral, details: Error)
    case onDiscoverServices(peripheral: BluetoothPeripheral, details: Error)
    case onDiscoverIncludedServices(service: BluetoothService, details: Error)
    case onDiscoverCharacteristics(service: BluetoothService, details: Error)
    case onReadValueForCharacteristic(characteristic: BluetoothCharacteristic, details: Error)
    case onWriteValueForCharacteristic(characteristic: BluetoothCharacteristic, details: Error)
    case onDiscoverDescriptors(characteristic: BluetoothCharacteristic, details: Error)
    case onReadValueForDescriptor(descriptor: BluetoothDescriptor, details: Error)
    case onWriteValueForDescriptor(descriptor: BluetoothDescriptor, details: Error)
    case onOpenChannel(peripheral: BluetoothPeripheral, PSM: CBL2CAPPSM, details: Error)
    case onPublishChannel(PSM: CBL2CAPPSM, details: Error)
    case onUnpublishChannel(PSM: CBL2CAPPSM, details: Error)
    case onAddService(service: BluetoothService, details: Error)
    case failOnStartAdvertising(error: Error?)
}

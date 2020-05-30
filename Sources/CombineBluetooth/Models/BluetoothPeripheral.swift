import Combine
import CoreBluetooth
import Foundation

// sourcery: AutoMockable
public protocol BluetoothPeripheral: BluetoothPeer {
    var name: String? { get }
    var state: CBPeripheralState { get }
    var services: [BluetoothService]? { get }
    var canSendWriteWithoutResponse: Bool { get }
    var isReadyAgainForWriteWithoutResponse: AnyPublisher<Void, Never> { get }
    func readRSSI() -> Promise<NSNumber, BluetoothError>
    func discoverServices(_ serviceUUIDs: [CBUUID]?) -> AnyPublisher<BluetoothService, BluetoothError>
    func discoverIncludedServices(_ includedServiceUUIDs: [CBUUID]?, for service: BluetoothService) -> AnyPublisher<BluetoothService, BluetoothError>
    func discoverCharacteristics(_ characteristicUUIDs: [CBUUID]?, for service: BluetoothService) -> AnyPublisher<BluetoothCharacteristic, BluetoothError>
    func readCharacteristicValue(_ characteristic: BluetoothCharacteristic) -> Promise<BluetoothCharacteristic, BluetoothError>
    func maximumWriteValueLength(for type: CBCharacteristicWriteType) -> Int
    func writeValue(_ data: Data, for characteristic: BluetoothCharacteristic, type: CBCharacteristicWriteType) -> Promise<BluetoothCharacteristic, BluetoothError>
    func notifyValue(for characteristic: BluetoothCharacteristic) -> AnyPublisher<BluetoothCharacteristic, BluetoothError>
    func discoverDescriptors(for characteristic: BluetoothCharacteristic) -> AnyPublisher<BluetoothDescriptor, BluetoothError>
    func readDescriptorValue(_ descriptor: BluetoothDescriptor) -> Promise<BluetoothDescriptor, BluetoothError>
    func writeValue(_ data: Data, for descriptor: BluetoothDescriptor) -> Promise<BluetoothDescriptor, BluetoothError>
    func openL2CAPChannel(PSM: CBL2CAPPSM) -> Promise<L2CAPChannel, BluetoothError>
}

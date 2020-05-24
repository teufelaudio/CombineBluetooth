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
    func readRSSI() -> Deferred<Future<NSNumber, BluetoothError>>
    func discoverServices(_ serviceUUIDs: [CBUUID]?) -> Deferred<Future<[BluetoothService], BluetoothError>>
    func discoverIncludedServices(_ includedServiceUUIDs: [CBUUID]?, for service: BluetoothService) -> Deferred<Future<[BluetoothService], BluetoothError>>
    func discoverCharacteristics(_ characteristicUUIDs: [CBUUID]?, for service: BluetoothService) -> Deferred<Future<[BluetoothCharacteristic], BluetoothError>>
    func readCharacteristicValue(_ characteristic: BluetoothCharacteristic) -> Deferred<Future<BluetoothCharacteristic, BluetoothError>>
    func maximumWriteValueLength(for type: CBCharacteristicWriteType) -> Int
    func writeValue(_ data: Data, for characteristic: BluetoothCharacteristic, type: CBCharacteristicWriteType) -> Deferred<Future<BluetoothCharacteristic, BluetoothError>>
    func notifyValue(for characteristic: BluetoothCharacteristic) -> AnyPublisher<BluetoothCharacteristic, BluetoothError>
    func discoverDescriptors(for characteristic: BluetoothCharacteristic) -> Deferred<Future<[BluetoothDescriptor], BluetoothError>>
    func readDescriptorValue(_ descriptor: BluetoothDescriptor) -> Deferred<Future<BluetoothDescriptor, BluetoothError>>
    func writeValue(_ data: Data, for descriptor: BluetoothDescriptor) -> Deferred<Future<BluetoothDescriptor, BluetoothError>>
    func openL2CAPChannel(PSM: CBL2CAPPSM) -> Deferred<Future<L2CAPChannel, BluetoothError>>
}

import Combine
import Foundation
import CoreBluetooth

public protocol BluetoothPeripheral {
    var name: String? { get }
    var state: CBPeripheralState { get }
    var services: [BluetoothService]? { get }
    var canSendWriteWithoutResponse: Bool { get }
    func readRSSI() -> Deferred<Future<NSNumber, BluetoothError>>
    func discoverServices(_ serviceUUIDs: [CBUUID]?) -> Deferred<Future<[BluetoothService], BluetoothError>>
    func discoverIncludedServices(_ includedServiceUUIDs: [CBUUID]?, for service: CBService) -> Deferred<Future<[BluetoothService], BluetoothError>>
    func discoverCharacteristics(_ characteristicUUIDs: [CBUUID]?, for service: BluetoothService) -> Deferred<Future<[BluetoothCharacteristic], BluetoothError>>
    func readValue(for characteristic: BluetoothCharacteristic) -> Deferred<Future<BluetoothCharacteristic, BluetoothError>>
    func maximumWriteValueLength(for type: CBCharacteristicWriteType) -> Int
    func writeValue(_ data: Data, for characteristic: BluetoothCharacteristic, type: CBCharacteristicWriteType) -> Deferred<Future<BluetoothCharacteristic, BluetoothError>>
    func notifyValue(for characteristic: BluetoothCharacteristic) -> AnyPublisher<BluetoothCharacteristic, BluetoothError>
    func discoverDescriptors(for characteristic: BluetoothCharacteristic) -> Deferred<Future<[BluetoothDescriptor], BluetoothError>>
    func readValue(for descriptor: BluetoothDescriptor) -> Deferred<Future<BluetoothDescriptor, BluetoothError>>
    func writeValue(_ data: Data, for descriptor: BluetoothDescriptor) -> Deferred<Future<BluetoothDescriptor, BluetoothError>>
    func openL2CAPChannel(PSM: CBL2CAPPSM) -> Deferred<Future<CBL2CAPChannel, BluetoothError>>
}

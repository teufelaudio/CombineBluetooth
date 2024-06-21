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
    
    /// `CBPeripheralDelegate` which gets referenced weakly and peripheral's delegate calls
    /// get proxied to. Be aware that the `CBPeripheral` within the delegate methods get passed by reference
    /// so in case you access their delegate you might overwrite it, thus cancelling this proxyDelegate.
    var proxyDelegate: CBPeripheralDelegate? { get set }
    
    func readRSSI() -> AnyPublisher<NSNumber, BluetoothError>
    func discoverServices(_ serviceUUIDs: [CBUUID]?) -> AnyPublisher<BluetoothService, BluetoothError>
    func discoverIncludedServices(_ includedServiceUUIDs: [CBUUID]?, for service: BluetoothService) -> AnyPublisher<BluetoothService, BluetoothError>
    func discoverCharacteristics(_ characteristicUUIDs: [CBUUID]?, for service: BluetoothService) -> AnyPublisher<BluetoothCharacteristic, BluetoothError>
    func readCharacteristicValue(_ characteristic: BluetoothCharacteristic) -> AnyPublisher<BluetoothCharacteristic, BluetoothError>
    func maximumWriteValueLength(for type: CBCharacteristicWriteType) -> Int
    func writeValue(_ data: Data, for characteristic: BluetoothCharacteristic, type: CBCharacteristicWriteType) -> AnyPublisher<BluetoothCharacteristic, BluetoothError>
    func notifyValue(for characteristic: BluetoothCharacteristic) -> AnyPublisher<BluetoothCharacteristic, BluetoothError>
    func discoverDescriptors(for characteristic: BluetoothCharacteristic) -> AnyPublisher<BluetoothDescriptor, BluetoothError>
    func readDescriptorValue(_ descriptor: BluetoothDescriptor) -> AnyPublisher<BluetoothDescriptor, BluetoothError>
    func writeValue(_ data: Data, for descriptor: BluetoothDescriptor) -> AnyPublisher<BluetoothDescriptor, BluetoothError>
    func openL2CAPChannel(PSM: CBL2CAPPSM) -> AnyPublisher<L2CAPChannel, BluetoothError>
}

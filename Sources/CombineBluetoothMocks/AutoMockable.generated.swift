// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable all

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

import Combine
import CombineBluetooth
import CoreBluetooth

class ATTRequestMock: ATTRequest {
    var central: BluetoothCentral {
        get { return underlyingCentral }
        set(value) { underlyingCentral = value }
    }
    var underlyingCentral: BluetoothCentral!
    var characteristic: BluetoothCharacteristic {
        get { return underlyingCharacteristic }
        set(value) { underlyingCharacteristic = value }
    }
    var underlyingCharacteristic: BluetoothCharacteristic!
    var offset: Int {
        get { return underlyingOffset }
        set(value) { underlyingOffset = value }
    }
    var underlyingOffset: Int!
    var value: Data?
}
class AdvertisingPeripheralMock: AdvertisingPeripheral {
    var advertisementData: [String: Any] = [:]
    var rssi: NSNumber {
        get { return underlyingRssi }
        set(value) { underlyingRssi = value }
    }
    var underlyingRssi: NSNumber!
    var peripheral: BluetoothPeripheral {
        get { return underlyingPeripheral }
        set(value) { underlyingPeripheral = value }
    }
    var underlyingPeripheral: BluetoothPeripheral!
}
class BluetoothCentralMock: BluetoothCentral {
    var maximumUpdateValueLength: Int {
        get { return underlyingMaximumUpdateValueLength }
        set(value) { underlyingMaximumUpdateValueLength = value }
    }
    var underlyingMaximumUpdateValueLength: Int!
    var id: UUID {
        get { return underlyingId }
        set(value) { underlyingId = value }
    }
    var underlyingId: UUID!
}
class BluetoothCharacteristicMock: BluetoothCharacteristic {
    var id: CBUUID {
        get { return underlyingId }
        set(value) { underlyingId = value }
    }
    var underlyingId: CBUUID!
    var service: BluetoothService {
        get { return underlyingService }
        set(value) { underlyingService = value }
    }
    var underlyingService: BluetoothService!
    var properties: CBCharacteristicProperties {
        get { return underlyingProperties }
        set(value) { underlyingProperties = value }
    }
    var underlyingProperties: CBCharacteristicProperties!
    var value: Data?
    var descriptors: [BluetoothDescriptor]?
    var isNotifying: Bool {
        get { return underlyingIsNotifying }
        set(value) { underlyingIsNotifying = value }
    }
    var underlyingIsNotifying: Bool!
    var permissions: CBAttributePermissions?
    var subscribedCentrals: [BluetoothCentral]?
}
class BluetoothDescriptorMock: BluetoothDescriptor {
    var id: CBUUID {
        get { return underlyingId }
        set(value) { underlyingId = value }
    }
    var underlyingId: CBUUID!
    var characteristic: BluetoothCharacteristic {
        get { return underlyingCharacteristic }
        set(value) { underlyingCharacteristic = value }
    }
    var underlyingCharacteristic: BluetoothCharacteristic!
    var value: Any?
}
class BluetoothManagerMock: BluetoothManager {
    var state: AnyPublisher<CBManagerState, BluetoothError> {
        get { return underlyingState }
        set(value) { underlyingState = value }
    }
    var underlyingState: AnyPublisher<CBManagerState, BluetoothError>!
    var stateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError> {
        get { return underlyingStateRestoration }
        set(value) { underlyingStateRestoration = value }
    }
    var underlyingStateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError>!
}
class BluetoothPeerMock: BluetoothPeer {
    var id: UUID {
        get { return underlyingId }
        set(value) { underlyingId = value }
    }
    var underlyingId: UUID!
}
class BluetoothPeripheralMock: BluetoothPeripheral {
    var name: String?
    var state: CBPeripheralState {
        get { return underlyingState }
        set(value) { underlyingState = value }
    }
    var underlyingState: CBPeripheralState!
    var services: [BluetoothService]?
    var canSendWriteWithoutResponse: Bool {
        get { return underlyingCanSendWriteWithoutResponse }
        set(value) { underlyingCanSendWriteWithoutResponse = value }
    }
    var underlyingCanSendWriteWithoutResponse: Bool!
    var isReadyAgainForWriteWithoutResponse: AnyPublisher<Void, Never> {
        get { return underlyingIsReadyAgainForWriteWithoutResponse }
        set(value) { underlyingIsReadyAgainForWriteWithoutResponse = value }
    }
    var underlyingIsReadyAgainForWriteWithoutResponse: AnyPublisher<Void, Never>!
    var id: UUID {
        get { return underlyingId }
        set(value) { underlyingId = value }
    }
    var underlyingId: UUID!
    //MARK: - readRSSI

    var readRSSICallsCount = 0
    var readRSSICalled: Bool {
        return readRSSICallsCount > 0
    }
    var readRSSIReturnValue: Deferred<Future<NSNumber, BluetoothError>>!
    var readRSSIClosure: (() -> Deferred<Future<NSNumber, BluetoothError>>)?

    func readRSSI() -> Deferred<Future<NSNumber, BluetoothError>> {
        readRSSICallsCount += 1
        return readRSSIClosure.map({ $0() }) ?? readRSSIReturnValue
    }

    //MARK: - discoverServices

    var discoverServicesCallsCount = 0
    var discoverServicesCalled: Bool {
        return discoverServicesCallsCount > 0
    }
    var discoverServicesReceivedServiceUUIDs: [CBUUID]?
    var discoverServicesReturnValue: Deferred<Future<[BluetoothService], BluetoothError>>!
    var discoverServicesClosure: (([CBUUID]?) -> Deferred<Future<[BluetoothService], BluetoothError>>)?

    func discoverServices(_ serviceUUIDs: [CBUUID]?) -> Deferred<Future<[BluetoothService], BluetoothError>> {
        discoverServicesCallsCount += 1
        discoverServicesReceivedServiceUUIDs = serviceUUIDs
        return discoverServicesClosure.map({ $0(serviceUUIDs) }) ?? discoverServicesReturnValue
    }

    //MARK: - discoverIncludedServices

    var discoverIncludedServicesForCallsCount = 0
    var discoverIncludedServicesForCalled: Bool {
        return discoverIncludedServicesForCallsCount > 0
    }
    var discoverIncludedServicesForReceivedArguments: (includedServiceUUIDs: [CBUUID]?, service: BluetoothService)?
    var discoverIncludedServicesForReturnValue: Deferred<Future<[BluetoothService], BluetoothError>>!
    var discoverIncludedServicesForClosure: (([CBUUID]?, BluetoothService) -> Deferred<Future<[BluetoothService], BluetoothError>>)?

    func discoverIncludedServices(_ includedServiceUUIDs: [CBUUID]?, for service: BluetoothService) -> Deferred<Future<[BluetoothService], BluetoothError>> {
        discoverIncludedServicesForCallsCount += 1
        discoverIncludedServicesForReceivedArguments = (includedServiceUUIDs: includedServiceUUIDs, service: service)
        return discoverIncludedServicesForClosure.map({ $0(includedServiceUUIDs, service) }) ?? discoverIncludedServicesForReturnValue
    }

    //MARK: - discoverCharacteristics

    var discoverCharacteristicsForCallsCount = 0
    var discoverCharacteristicsForCalled: Bool {
        return discoverCharacteristicsForCallsCount > 0
    }
    var discoverCharacteristicsForReceivedArguments: (characteristicUUIDs: [CBUUID]?, service: BluetoothService)?
    var discoverCharacteristicsForReturnValue: Deferred<Future<[BluetoothCharacteristic], BluetoothError>>!
    var discoverCharacteristicsForClosure: (([CBUUID]?, BluetoothService) -> Deferred<Future<[BluetoothCharacteristic], BluetoothError>>)?

    func discoverCharacteristics(_ characteristicUUIDs: [CBUUID]?, for service: BluetoothService) -> Deferred<Future<[BluetoothCharacteristic], BluetoothError>> {
        discoverCharacteristicsForCallsCount += 1
        discoverCharacteristicsForReceivedArguments = (characteristicUUIDs: characteristicUUIDs, service: service)
        return discoverCharacteristicsForClosure.map({ $0(characteristicUUIDs, service) }) ?? discoverCharacteristicsForReturnValue
    }

    //MARK: - readCharacteristicValue

    var readCharacteristicValueCallsCount = 0
    var readCharacteristicValueCalled: Bool {
        return readCharacteristicValueCallsCount > 0
    }
    var readCharacteristicValueReceivedCharacteristic: BluetoothCharacteristic?
    var readCharacteristicValueReturnValue: Deferred<Future<BluetoothCharacteristic, BluetoothError>>!
    var readCharacteristicValueClosure: ((BluetoothCharacteristic) -> Deferred<Future<BluetoothCharacteristic, BluetoothError>>)?

    func readCharacteristicValue(_ characteristic: BluetoothCharacteristic) -> Deferred<Future<BluetoothCharacteristic, BluetoothError>> {
        readCharacteristicValueCallsCount += 1
        readCharacteristicValueReceivedCharacteristic = characteristic
        return readCharacteristicValueClosure.map({ $0(characteristic) }) ?? readCharacteristicValueReturnValue
    }

    //MARK: - maximumWriteValueLength

    var maximumWriteValueLengthForCallsCount = 0
    var maximumWriteValueLengthForCalled: Bool {
        return maximumWriteValueLengthForCallsCount > 0
    }
    var maximumWriteValueLengthForReceivedType: CBCharacteristicWriteType?
    var maximumWriteValueLengthForReturnValue: Int!
    var maximumWriteValueLengthForClosure: ((CBCharacteristicWriteType) -> Int)?

    func maximumWriteValueLength(for type: CBCharacteristicWriteType) -> Int {
        maximumWriteValueLengthForCallsCount += 1
        maximumWriteValueLengthForReceivedType = type
        return maximumWriteValueLengthForClosure.map({ $0(type) }) ?? maximumWriteValueLengthForReturnValue
    }

    //MARK: - writeValue

    var writeValueForTypeCallsCount = 0
    var writeValueForTypeCalled: Bool {
        return writeValueForTypeCallsCount > 0
    }
    var writeValueForTypeReceivedArguments: (data: Data, characteristic: BluetoothCharacteristic, type: CBCharacteristicWriteType)?
    var writeValueForTypeReturnValue: Deferred<Future<BluetoothCharacteristic, BluetoothError>>!
    var writeValueForTypeClosure: ((Data, BluetoothCharacteristic, CBCharacteristicWriteType) -> Deferred<Future<BluetoothCharacteristic, BluetoothError>>)?

    func writeValue(_ data: Data, for characteristic: BluetoothCharacteristic, type: CBCharacteristicWriteType) -> Deferred<Future<BluetoothCharacteristic, BluetoothError>> {
        writeValueForTypeCallsCount += 1
        writeValueForTypeReceivedArguments = (data: data, characteristic: characteristic, type: type)
        return writeValueForTypeClosure.map({ $0(data, characteristic, type) }) ?? writeValueForTypeReturnValue
    }

    //MARK: - notifyValue

    var notifyValueForCallsCount = 0
    var notifyValueForCalled: Bool {
        return notifyValueForCallsCount > 0
    }
    var notifyValueForReceivedCharacteristic: BluetoothCharacteristic?
    var notifyValueForReturnValue: AnyPublisher<BluetoothCharacteristic, BluetoothError>!
    var notifyValueForClosure: ((BluetoothCharacteristic) -> AnyPublisher<BluetoothCharacteristic, BluetoothError>)?

    func notifyValue(for characteristic: BluetoothCharacteristic) -> AnyPublisher<BluetoothCharacteristic, BluetoothError> {
        notifyValueForCallsCount += 1
        notifyValueForReceivedCharacteristic = characteristic
        return notifyValueForClosure.map({ $0(characteristic) }) ?? notifyValueForReturnValue
    }

    //MARK: - discoverDescriptors

    var discoverDescriptorsForCallsCount = 0
    var discoverDescriptorsForCalled: Bool {
        return discoverDescriptorsForCallsCount > 0
    }
    var discoverDescriptorsForReceivedCharacteristic: BluetoothCharacteristic?
    var discoverDescriptorsForReturnValue: Deferred<Future<[BluetoothDescriptor], BluetoothError>>!
    var discoverDescriptorsForClosure: ((BluetoothCharacteristic) -> Deferred<Future<[BluetoothDescriptor], BluetoothError>>)?

    func discoverDescriptors(for characteristic: BluetoothCharacteristic) -> Deferred<Future<[BluetoothDescriptor], BluetoothError>> {
        discoverDescriptorsForCallsCount += 1
        discoverDescriptorsForReceivedCharacteristic = characteristic
        return discoverDescriptorsForClosure.map({ $0(characteristic) }) ?? discoverDescriptorsForReturnValue
    }

    //MARK: - readDescriptorValue

    var readDescriptorValueCallsCount = 0
    var readDescriptorValueCalled: Bool {
        return readDescriptorValueCallsCount > 0
    }
    var readDescriptorValueReceivedDescriptor: BluetoothDescriptor?
    var readDescriptorValueReturnValue: Deferred<Future<BluetoothDescriptor, BluetoothError>>!
    var readDescriptorValueClosure: ((BluetoothDescriptor) -> Deferred<Future<BluetoothDescriptor, BluetoothError>>)?

    func readDescriptorValue(_ descriptor: BluetoothDescriptor) -> Deferred<Future<BluetoothDescriptor, BluetoothError>> {
        readDescriptorValueCallsCount += 1
        readDescriptorValueReceivedDescriptor = descriptor
        return readDescriptorValueClosure.map({ $0(descriptor) }) ?? readDescriptorValueReturnValue
    }

    //MARK: - writeValue

    var writeValueForCallsCount = 0
    var writeValueForCalled: Bool {
        return writeValueForCallsCount > 0
    }
    var writeValueForReceivedArguments: (data: Data, descriptor: BluetoothDescriptor)?
    var writeValueForReturnValue: Deferred<Future<BluetoothDescriptor, BluetoothError>>!
    var writeValueForClosure: ((Data, BluetoothDescriptor) -> Deferred<Future<BluetoothDescriptor, BluetoothError>>)?

    func writeValue(_ data: Data, for descriptor: BluetoothDescriptor) -> Deferred<Future<BluetoothDescriptor, BluetoothError>> {
        writeValueForCallsCount += 1
        writeValueForReceivedArguments = (data: data, descriptor: descriptor)
        return writeValueForClosure.map({ $0(data, descriptor) }) ?? writeValueForReturnValue
    }

    //MARK: - openL2CAPChannel

    var openL2CAPChannelPSMCallsCount = 0
    var openL2CAPChannelPSMCalled: Bool {
        return openL2CAPChannelPSMCallsCount > 0
    }
    var openL2CAPChannelPSMReceivedPSM: CBL2CAPPSM?
    var openL2CAPChannelPSMReturnValue: Deferred<Future<L2CAPChannel, BluetoothError>>!
    var openL2CAPChannelPSMClosure: ((CBL2CAPPSM) -> Deferred<Future<L2CAPChannel, BluetoothError>>)?

    func openL2CAPChannel(PSM: CBL2CAPPSM) -> Deferred<Future<L2CAPChannel, BluetoothError>> {
        openL2CAPChannelPSMCallsCount += 1
        openL2CAPChannelPSMReceivedPSM = PSM
        return openL2CAPChannelPSMClosure.map({ $0(PSM) }) ?? openL2CAPChannelPSMReturnValue
    }

}
class BluetoothServiceMock: BluetoothService {
    var id: CBUUID {
        get { return underlyingId }
        set(value) { underlyingId = value }
    }
    var underlyingId: CBUUID!
    var peripheral: BluetoothPeripheral {
        get { return underlyingPeripheral }
        set(value) { underlyingPeripheral = value }
    }
    var underlyingPeripheral: BluetoothPeripheral!
    var isPrimary: Bool {
        get { return underlyingIsPrimary }
        set(value) { underlyingIsPrimary = value }
    }
    var underlyingIsPrimary: Bool!
    var includedServices: [BluetoothService]?
    var characteristics: [BluetoothCharacteristic]?
}
class CentralManagerMock: CentralManager {
    var isScanning: AnyPublisher<Bool, Never> {
        get { return underlyingIsScanning }
        set(value) { underlyingIsScanning = value }
    }
    var underlyingIsScanning: AnyPublisher<Bool, Never>!
    var peripheralConnection: AnyPublisher<PeripheralConnectionEvent, Never> {
        get { return underlyingPeripheralConnection }
        set(value) { underlyingPeripheralConnection = value }
    }
    var underlyingPeripheralConnection: AnyPublisher<PeripheralConnectionEvent, Never>!
    var state: AnyPublisher<CBManagerState, BluetoothError> {
        get { return underlyingState }
        set(value) { underlyingState = value }
    }
    var underlyingState: AnyPublisher<CBManagerState, BluetoothError>!
    var stateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError> {
        get { return underlyingStateRestoration }
        set(value) { underlyingStateRestoration = value }
    }
    var underlyingStateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError>!
    //MARK: - scanForPeripherals

    var scanForPeripheralsCallsCount = 0
    var scanForPeripheralsCalled: Bool {
        return scanForPeripheralsCallsCount > 0
    }
    var scanForPeripheralsReturnValue: AnyPublisher<AdvertisingPeripheral, BluetoothError>!
    var scanForPeripheralsClosure: (() -> AnyPublisher<AdvertisingPeripheral, BluetoothError>)?

    func scanForPeripherals() -> AnyPublisher<AdvertisingPeripheral, BluetoothError> {
        scanForPeripheralsCallsCount += 1
        return scanForPeripheralsClosure.map({ $0() }) ?? scanForPeripheralsReturnValue
    }

    //MARK: - scanForPeripherals

    var scanForPeripheralsWithServicesCallsCount = 0
    var scanForPeripheralsWithServicesCalled: Bool {
        return scanForPeripheralsWithServicesCallsCount > 0
    }
    var scanForPeripheralsWithServicesReceivedServiceUUIDs: [CBUUID]?
    var scanForPeripheralsWithServicesReturnValue: AnyPublisher<AdvertisingPeripheral, BluetoothError>!
    var scanForPeripheralsWithServicesClosure: (([CBUUID]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError>)?

    func scanForPeripherals(withServices serviceUUIDs: [CBUUID]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError> {
        scanForPeripheralsWithServicesCallsCount += 1
        scanForPeripheralsWithServicesReceivedServiceUUIDs = serviceUUIDs
        return scanForPeripheralsWithServicesClosure.map({ $0(serviceUUIDs) }) ?? scanForPeripheralsWithServicesReturnValue
    }

    //MARK: - scanForPeripherals

    var scanForPeripheralsWithServicesOptionsCallsCount = 0
    var scanForPeripheralsWithServicesOptionsCalled: Bool {
        return scanForPeripheralsWithServicesOptionsCallsCount > 0
    }
    var scanForPeripheralsWithServicesOptionsReceivedArguments: (serviceUUIDs: [CBUUID], options: [String: Any])?
    var scanForPeripheralsWithServicesOptionsReturnValue: AnyPublisher<AdvertisingPeripheral, BluetoothError>!
    var scanForPeripheralsWithServicesOptionsClosure: (([CBUUID], [String: Any]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError>)?

    func scanForPeripherals(withServices serviceUUIDs: [CBUUID], options: [String: Any]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError> {
        scanForPeripheralsWithServicesOptionsCallsCount += 1
        scanForPeripheralsWithServicesOptionsReceivedArguments = (serviceUUIDs: serviceUUIDs, options: options)
        return scanForPeripheralsWithServicesOptionsClosure.map({ $0(serviceUUIDs, options) }) ?? scanForPeripheralsWithServicesOptionsReturnValue
    }

    //MARK: - scanForPeripherals

    var scanForPeripheralsOptionsCallsCount = 0
    var scanForPeripheralsOptionsCalled: Bool {
        return scanForPeripheralsOptionsCallsCount > 0
    }
    var scanForPeripheralsOptionsReceivedOptions: [String: Any]?
    var scanForPeripheralsOptionsReturnValue: AnyPublisher<AdvertisingPeripheral, BluetoothError>!
    var scanForPeripheralsOptionsClosure: (([String: Any]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError>)?

    func scanForPeripherals(options: [String: Any]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError> {
        scanForPeripheralsOptionsCallsCount += 1
        scanForPeripheralsOptionsReceivedOptions = options
        return scanForPeripheralsOptionsClosure.map({ $0(options) }) ?? scanForPeripheralsOptionsReturnValue
    }

    //MARK: - retrievePeripherals

    var retrievePeripheralsWithIdentifiersCallsCount = 0
    var retrievePeripheralsWithIdentifiersCalled: Bool {
        return retrievePeripheralsWithIdentifiersCallsCount > 0
    }
    var retrievePeripheralsWithIdentifiersReceivedIdentifiers: [UUID]?
    var retrievePeripheralsWithIdentifiersReturnValue: [BluetoothPeripheral]!
    var retrievePeripheralsWithIdentifiersClosure: (([UUID]) -> [BluetoothPeripheral])?

    func retrievePeripherals(withIdentifiers identifiers: [UUID]) -> [BluetoothPeripheral] {
        retrievePeripheralsWithIdentifiersCallsCount += 1
        retrievePeripheralsWithIdentifiersReceivedIdentifiers = identifiers
        return retrievePeripheralsWithIdentifiersClosure.map({ $0(identifiers) }) ?? retrievePeripheralsWithIdentifiersReturnValue
    }

    //MARK: - retrieveConnectedPeripherals

    var retrieveConnectedPeripheralsWithServicesCallsCount = 0
    var retrieveConnectedPeripheralsWithServicesCalled: Bool {
        return retrieveConnectedPeripheralsWithServicesCallsCount > 0
    }
    var retrieveConnectedPeripheralsWithServicesReceivedServiceUUIDs: [CBUUID]?
    var retrieveConnectedPeripheralsWithServicesReturnValue: [BluetoothPeripheral]!
    var retrieveConnectedPeripheralsWithServicesClosure: (([CBUUID]) -> [BluetoothPeripheral])?

    func retrieveConnectedPeripherals(withServices serviceUUIDs: [CBUUID]) -> [BluetoothPeripheral] {
        retrieveConnectedPeripheralsWithServicesCallsCount += 1
        retrieveConnectedPeripheralsWithServicesReceivedServiceUUIDs = serviceUUIDs
        return retrieveConnectedPeripheralsWithServicesClosure.map({ $0(serviceUUIDs) }) ?? retrieveConnectedPeripheralsWithServicesReturnValue
    }

    //MARK: - connect

    var connectCallsCount = 0
    var connectCalled: Bool {
        return connectCallsCount > 0
    }
    var connectReceivedPeripheral: BluetoothPeripheral?
    var connectReturnValue: AnyPublisher<BluetoothPeripheral, BluetoothError>!
    var connectClosure: ((BluetoothPeripheral) -> AnyPublisher<BluetoothPeripheral, BluetoothError>)?

    func connect(_ peripheral: BluetoothPeripheral) -> AnyPublisher<BluetoothPeripheral, BluetoothError> {
        connectCallsCount += 1
        connectReceivedPeripheral = peripheral
        return connectClosure.map({ $0(peripheral) }) ?? connectReturnValue
    }

    //MARK: - connect

    var connectOptionsCallsCount = 0
    var connectOptionsCalled: Bool {
        return connectOptionsCallsCount > 0
    }
    var connectOptionsReceivedArguments: (peripheral: BluetoothPeripheral, options: [String : Any])?
    var connectOptionsReturnValue: AnyPublisher<BluetoothPeripheral, BluetoothError>!
    var connectOptionsClosure: ((BluetoothPeripheral, [String : Any]) -> AnyPublisher<BluetoothPeripheral, BluetoothError>)?

    func connect(_ peripheral: BluetoothPeripheral, options: [String : Any]) -> AnyPublisher<BluetoothPeripheral, BluetoothError> {
        connectOptionsCallsCount += 1
        connectOptionsReceivedArguments = (peripheral: peripheral, options: options)
        return connectOptionsClosure.map({ $0(peripheral, options) }) ?? connectOptionsReturnValue
    }

}
class L2CAPChannelMock: L2CAPChannel {
    var peer: BluetoothPeer {
        get { return underlyingPeer }
        set(value) { underlyingPeer = value }
    }
    var underlyingPeer: BluetoothPeer!
    var inputStream: InputStream {
        get { return underlyingInputStream }
        set(value) { underlyingInputStream = value }
    }
    var underlyingInputStream: InputStream!
    var outputStream: OutputStream {
        get { return underlyingOutputStream }
        set(value) { underlyingOutputStream = value }
    }
    var underlyingOutputStream: OutputStream!
    var psm: CBL2CAPPSM {
        get { return underlyingPsm }
        set(value) { underlyingPsm = value }
    }
    var underlyingPsm: CBL2CAPPSM!
}
class PeripheralManagerMock: PeripheralManager {
    var isAdvertising: AnyPublisher<Bool, Never> {
        get { return underlyingIsAdvertising }
        set(value) { underlyingIsAdvertising = value }
    }
    var underlyingIsAdvertising: AnyPublisher<Bool, Never>!
    var isReadyAgainForWriteWithoutResponse: AnyPublisher<Void, Never> {
        get { return underlyingIsReadyAgainForWriteWithoutResponse }
        set(value) { underlyingIsReadyAgainForWriteWithoutResponse = value }
    }
    var underlyingIsReadyAgainForWriteWithoutResponse: AnyPublisher<Void, Never>!
    var state: AnyPublisher<CBManagerState, BluetoothError> {
        get { return underlyingState }
        set(value) { underlyingState = value }
    }
    var underlyingState: AnyPublisher<CBManagerState, BluetoothError>!
    var stateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError> {
        get { return underlyingStateRestoration }
        set(value) { underlyingStateRestoration = value }
    }
    var underlyingStateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError>!
    //MARK: - startAdvertising

    var startAdvertisingCallsCount = 0
    var startAdvertisingCalled: Bool {
        return startAdvertisingCallsCount > 0
    }
    var startAdvertisingReturnValue: AnyPublisher<Void, BluetoothError>!
    var startAdvertisingClosure: (() -> AnyPublisher<Void, BluetoothError>)?

    func startAdvertising() -> AnyPublisher<Void, BluetoothError> {
        startAdvertisingCallsCount += 1
        return startAdvertisingClosure.map({ $0() }) ?? startAdvertisingReturnValue
    }

    //MARK: - startAdvertising

    var startAdvertisingAdvertisementDataCallsCount = 0
    var startAdvertisingAdvertisementDataCalled: Bool {
        return startAdvertisingAdvertisementDataCallsCount > 0
    }
    var startAdvertisingAdvertisementDataReceivedAdvertisementData: [String: Any]?
    var startAdvertisingAdvertisementDataReturnValue: AnyPublisher<Void, BluetoothError>!
    var startAdvertisingAdvertisementDataClosure: (([String: Any]) -> AnyPublisher<Void, BluetoothError>)?

    func startAdvertising(advertisementData: [String: Any]) -> AnyPublisher<Void, BluetoothError> {
        startAdvertisingAdvertisementDataCallsCount += 1
        startAdvertisingAdvertisementDataReceivedAdvertisementData = advertisementData
        return startAdvertisingAdvertisementDataClosure.map({ $0(advertisementData) }) ?? startAdvertisingAdvertisementDataReturnValue
    }

    //MARK: - setDesiredConnectionLatency

    var setDesiredConnectionLatencyForCallsCount = 0
    var setDesiredConnectionLatencyForCalled: Bool {
        return setDesiredConnectionLatencyForCallsCount > 0
    }
    var setDesiredConnectionLatencyForReceivedArguments: (latency: CBPeripheralManagerConnectionLatency, central: BluetoothCentral)?
    var setDesiredConnectionLatencyForReturnValue: Result<Void, BluetoothError>!
    var setDesiredConnectionLatencyForClosure: ((CBPeripheralManagerConnectionLatency, BluetoothCentral) -> Result<Void, BluetoothError>)?

    func setDesiredConnectionLatency(_ latency: CBPeripheralManagerConnectionLatency, for central: BluetoothCentral) -> Result<Void, BluetoothError> {
        setDesiredConnectionLatencyForCallsCount += 1
        setDesiredConnectionLatencyForReceivedArguments = (latency: latency, central: central)
        return setDesiredConnectionLatencyForClosure.map({ $0(latency, central) }) ?? setDesiredConnectionLatencyForReturnValue
    }

    //MARK: - add

    var addCallsCount = 0
    var addCalled: Bool {
        return addCallsCount > 0
    }
    var addReceivedService: BluetoothService?
    var addReturnValue: Deferred<Future<BluetoothService, BluetoothError>>!
    var addClosure: ((BluetoothService) -> Deferred<Future<BluetoothService, BluetoothError>>)?

    func add(_ service: BluetoothService) -> Deferred<Future<BluetoothService, BluetoothError>> {
        addCallsCount += 1
        addReceivedService = service
        return addClosure.map({ $0(service) }) ?? addReturnValue
    }

    //MARK: - remove

    var removeCallsCount = 0
    var removeCalled: Bool {
        return removeCallsCount > 0
    }
    var removeReceivedService: BluetoothService?
    var removeReturnValue: Result<BluetoothService, BluetoothError>!
    var removeClosure: ((BluetoothService) -> Result<BluetoothService, BluetoothError>)?

    func remove(_ service: BluetoothService) -> Result<BluetoothService, BluetoothError> {
        removeCallsCount += 1
        removeReceivedService = service
        return removeClosure.map({ $0(service) }) ?? removeReturnValue
    }

    //MARK: - removeAllServices

    var removeAllServicesCallsCount = 0
    var removeAllServicesCalled: Bool {
        return removeAllServicesCallsCount > 0
    }
    var removeAllServicesClosure: (() -> Void)?

    func removeAllServices() {
        removeAllServicesCallsCount += 1
        removeAllServicesClosure?()
    }

    //MARK: - respond

    var respondToWithResultCallsCount = 0
    var respondToWithResultCalled: Bool {
        return respondToWithResultCallsCount > 0
    }
    var respondToWithResultReceivedArguments: (request: ATTRequest, result: CBATTError.Code)?
    var respondToWithResultReturnValue: Result<Void, BluetoothError>!
    var respondToWithResultClosure: ((ATTRequest, CBATTError.Code) -> Result<Void, BluetoothError>)?

    func respond(to request: ATTRequest, withResult result: CBATTError.Code) -> Result<Void, BluetoothError> {
        respondToWithResultCallsCount += 1
        respondToWithResultReceivedArguments = (request: request, result: result)
        return respondToWithResultClosure.map({ $0(request, result) }) ?? respondToWithResultReturnValue
    }

    //MARK: - updateValue

    var updateValueForOnSubscribedCentralsCallsCount = 0
    var updateValueForOnSubscribedCentralsCalled: Bool {
        return updateValueForOnSubscribedCentralsCallsCount > 0
    }
    var updateValueForOnSubscribedCentralsReceivedArguments: (value: Data, characteristic: BluetoothCharacteristic, centrals: [BluetoothCentral]?)?
    var updateValueForOnSubscribedCentralsReturnValue: Result<Bool, BluetoothError>!
    var updateValueForOnSubscribedCentralsClosure: ((Data, BluetoothCharacteristic, [BluetoothCentral]?) -> Result<Bool, BluetoothError>)?

    func updateValue(_ value: Data, for characteristic: BluetoothCharacteristic, onSubscribedCentrals centrals: [BluetoothCentral]?) -> Result<Bool, BluetoothError> {
        updateValueForOnSubscribedCentralsCallsCount += 1
        updateValueForOnSubscribedCentralsReceivedArguments = (value: value, characteristic: characteristic, centrals: centrals)
        return updateValueForOnSubscribedCentralsClosure.map({ $0(value, characteristic, centrals) }) ?? updateValueForOnSubscribedCentralsReturnValue
    }

    //MARK: - publishL2CAPChannel

    var publishL2CAPChannelWithEncryptionCallsCount = 0
    var publishL2CAPChannelWithEncryptionCalled: Bool {
        return publishL2CAPChannelWithEncryptionCallsCount > 0
    }
    var publishL2CAPChannelWithEncryptionReceivedEncryptionRequired: Bool?
    var publishL2CAPChannelWithEncryptionReturnValue: Deferred<Future<CBL2CAPPSM, BluetoothError>>!
    var publishL2CAPChannelWithEncryptionClosure: ((Bool) -> Deferred<Future<CBL2CAPPSM, BluetoothError>>)?

    func publishL2CAPChannel(withEncryption encryptionRequired: Bool) -> Deferred<Future<CBL2CAPPSM, BluetoothError>> {
        publishL2CAPChannelWithEncryptionCallsCount += 1
        publishL2CAPChannelWithEncryptionReceivedEncryptionRequired = encryptionRequired
        return publishL2CAPChannelWithEncryptionClosure.map({ $0(encryptionRequired) }) ?? publishL2CAPChannelWithEncryptionReturnValue
    }

    //MARK: - unpublishL2CAPChannel

    var unpublishL2CAPChannelCallsCount = 0
    var unpublishL2CAPChannelCalled: Bool {
        return unpublishL2CAPChannelCallsCount > 0
    }
    var unpublishL2CAPChannelReceivedPSM: CBL2CAPPSM?
    var unpublishL2CAPChannelReturnValue: Deferred<Future<CBL2CAPPSM, BluetoothError>>!
    var unpublishL2CAPChannelClosure: ((CBL2CAPPSM) -> Deferred<Future<CBL2CAPPSM, BluetoothError>>)?

    func unpublishL2CAPChannel(_ PSM: CBL2CAPPSM) -> Deferred<Future<CBL2CAPPSM, BluetoothError>> {
        unpublishL2CAPChannelCallsCount += 1
        unpublishL2CAPChannelReceivedPSM = PSM
        return unpublishL2CAPChannelClosure.map({ $0(PSM) }) ?? unpublishL2CAPChannelReturnValue
    }

}

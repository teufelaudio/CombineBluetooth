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

open class ATTRequestMock: ATTRequest {
    open var central: BluetoothCentral {
        get { return underlyingCentral }
        set(value) { underlyingCentral = value }
    }
    open var underlyingCentral: BluetoothCentral!
    open var characteristic: BluetoothCharacteristic {
        get { return underlyingCharacteristic }
        set(value) { underlyingCharacteristic = value }
    }
    open var underlyingCharacteristic: BluetoothCharacteristic!
    open var offset: Int {
        get { return underlyingOffset }
        set(value) { underlyingOffset = value }
    }
    open var underlyingOffset: Int!
    open var value: Data?
}
open class AdvertisingPeripheralMock: AdvertisingPeripheral {
    open var advertisementData: [String: Any] = [:]
    open var rssi: NSNumber {
        get { return underlyingRssi }
        set(value) { underlyingRssi = value }
    }
    open var underlyingRssi: NSNumber!
    open var peripheral: BluetoothPeripheral {
        get { return underlyingPeripheral }
        set(value) { underlyingPeripheral = value }
    }
    open var underlyingPeripheral: BluetoothPeripheral!
}
open class BluetoothCentralMock: BluetoothCentral {
    open var maximumUpdateValueLength: Int {
        get { return underlyingMaximumUpdateValueLength }
        set(value) { underlyingMaximumUpdateValueLength = value }
    }
    open var underlyingMaximumUpdateValueLength: Int!
    open var id: UUID {
        get { return underlyingId }
        set(value) { underlyingId = value }
    }
    open var underlyingId: UUID!
}
open class BluetoothCharacteristicMock: BluetoothCharacteristic {
    open var id: CBUUID {
        get { return underlyingId }
        set(value) { underlyingId = value }
    }
    open var underlyingId: CBUUID!
    open var service: BluetoothService {
        get { return underlyingService }
        set(value) { underlyingService = value }
    }
    open var underlyingService: BluetoothService!
    open var properties: CBCharacteristicProperties {
        get { return underlyingProperties }
        set(value) { underlyingProperties = value }
    }
    open var underlyingProperties: CBCharacteristicProperties!
    open var value: Data?
    open var descriptors: [BluetoothDescriptor]?
    open var isNotifying: Bool {
        get { return underlyingIsNotifying }
        set(value) { underlyingIsNotifying = value }
    }
    open var underlyingIsNotifying: Bool!
    open var permissions: CBAttributePermissions?
    open var subscribedCentrals: [BluetoothCentral]?
}
open class BluetoothDescriptorMock: BluetoothDescriptor {
    open var id: CBUUID {
        get { return underlyingId }
        set(value) { underlyingId = value }
    }
    open var underlyingId: CBUUID!
    open var characteristic: BluetoothCharacteristic {
        get { return underlyingCharacteristic }
        set(value) { underlyingCharacteristic = value }
    }
    open var underlyingCharacteristic: BluetoothCharacteristic!
    open var value: Any?
}
open class BluetoothManagerMock: BluetoothManager {
    open var state: AnyPublisher<CBManagerState, BluetoothError> {
        get { return underlyingState }
        set(value) { underlyingState = value }
    }
    open var underlyingState: AnyPublisher<CBManagerState, BluetoothError>!
    open var stateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError> {
        get { return underlyingStateRestoration }
        set(value) { underlyingStateRestoration = value }
    }
    open var underlyingStateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError>!
}
open class BluetoothPeerMock: BluetoothPeer {
    open var id: UUID {
        get { return underlyingId }
        set(value) { underlyingId = value }
    }
    open var underlyingId: UUID!
}
open class BluetoothPeripheralMock: BluetoothPeripheral {
    open var name: String?
    open var state: CBPeripheralState {
        get { return underlyingState }
        set(value) { underlyingState = value }
    }
    open var underlyingState: CBPeripheralState!
    open var services: [BluetoothService]?
    open var canSendWriteWithoutResponse: Bool {
        get { return underlyingCanSendWriteWithoutResponse }
        set(value) { underlyingCanSendWriteWithoutResponse = value }
    }
    open var underlyingCanSendWriteWithoutResponse: Bool!
    open var isReadyAgainForWriteWithoutResponse: AnyPublisher<Void, Never> {
        get { return underlyingIsReadyAgainForWriteWithoutResponse }
        set(value) { underlyingIsReadyAgainForWriteWithoutResponse = value }
    }
    open var underlyingIsReadyAgainForWriteWithoutResponse: AnyPublisher<Void, Never>!
    open var id: UUID {
        get { return underlyingId }
        set(value) { underlyingId = value }
    }
    open var underlyingId: UUID!
    //MARK: - readRSSI

    open var readRSSICallsCount = 0
    open var readRSSICalled: Bool {
        return readRSSICallsCount > 0
    }
    open var readRSSIReturnValue: Promise<NSNumber, BluetoothError>!
    open var readRSSIClosure: (() -> Promise<NSNumber, BluetoothError>)?

    open func readRSSI() -> Promise<NSNumber, BluetoothError> {
        readRSSICallsCount += 1
        return readRSSIClosure.map({ $0() }) ?? readRSSIReturnValue
    }

    //MARK: - discoverServices

    open var discoverServicesCallsCount = 0
    open var discoverServicesCalled: Bool {
        return discoverServicesCallsCount > 0
    }
    open var discoverServicesReceivedServiceUUIDs: [CBUUID]?
    open var discoverServicesReturnValue: Promise<[BluetoothService], BluetoothError>!
    open var discoverServicesClosure: (([CBUUID]?) -> Promise<[BluetoothService], BluetoothError>)?

    open func discoverServices(_ serviceUUIDs: [CBUUID]?) -> Promise<[BluetoothService], BluetoothError> {
        discoverServicesCallsCount += 1
        discoverServicesReceivedServiceUUIDs = serviceUUIDs
        return discoverServicesClosure.map({ $0(serviceUUIDs) }) ?? discoverServicesReturnValue
    }

    //MARK: - discoverIncludedServices

    open var discoverIncludedServicesForCallsCount = 0
    open var discoverIncludedServicesForCalled: Bool {
        return discoverIncludedServicesForCallsCount > 0
    }
    open var discoverIncludedServicesForReceivedArguments: (includedServiceUUIDs: [CBUUID]?, service: BluetoothService)?
    open var discoverIncludedServicesForReturnValue: Promise<[BluetoothService], BluetoothError>!
    open var discoverIncludedServicesForClosure: (([CBUUID]?, BluetoothService) -> Promise<[BluetoothService], BluetoothError>)?

    open func discoverIncludedServices(_ includedServiceUUIDs: [CBUUID]?, for service: BluetoothService) -> Promise<[BluetoothService], BluetoothError> {
        discoverIncludedServicesForCallsCount += 1
        discoverIncludedServicesForReceivedArguments = (includedServiceUUIDs: includedServiceUUIDs, service: service)
        return discoverIncludedServicesForClosure.map({ $0(includedServiceUUIDs, service) }) ?? discoverIncludedServicesForReturnValue
    }

    //MARK: - discoverCharacteristics

    open var discoverCharacteristicsForCallsCount = 0
    open var discoverCharacteristicsForCalled: Bool {
        return discoverCharacteristicsForCallsCount > 0
    }
    open var discoverCharacteristicsForReceivedArguments: (characteristicUUIDs: [CBUUID]?, service: BluetoothService)?
    open var discoverCharacteristicsForReturnValue: Promise<[BluetoothCharacteristic], BluetoothError>!
    open var discoverCharacteristicsForClosure: (([CBUUID]?, BluetoothService) -> Promise<[BluetoothCharacteristic], BluetoothError>)?

    open func discoverCharacteristics(_ characteristicUUIDs: [CBUUID]?, for service: BluetoothService) -> Promise<[BluetoothCharacteristic], BluetoothError> {
        discoverCharacteristicsForCallsCount += 1
        discoverCharacteristicsForReceivedArguments = (characteristicUUIDs: characteristicUUIDs, service: service)
        return discoverCharacteristicsForClosure.map({ $0(characteristicUUIDs, service) }) ?? discoverCharacteristicsForReturnValue
    }

    //MARK: - readCharacteristicValue

    open var readCharacteristicValueCallsCount = 0
    open var readCharacteristicValueCalled: Bool {
        return readCharacteristicValueCallsCount > 0
    }
    open var readCharacteristicValueReceivedCharacteristic: BluetoothCharacteristic?
    open var readCharacteristicValueReturnValue: Promise<BluetoothCharacteristic, BluetoothError>!
    open var readCharacteristicValueClosure: ((BluetoothCharacteristic) -> Promise<BluetoothCharacteristic, BluetoothError>)?

    open func readCharacteristicValue(_ characteristic: BluetoothCharacteristic) -> Promise<BluetoothCharacteristic, BluetoothError> {
        readCharacteristicValueCallsCount += 1
        readCharacteristicValueReceivedCharacteristic = characteristic
        return readCharacteristicValueClosure.map({ $0(characteristic) }) ?? readCharacteristicValueReturnValue
    }

    //MARK: - maximumWriteValueLength

    open var maximumWriteValueLengthForCallsCount = 0
    open var maximumWriteValueLengthForCalled: Bool {
        return maximumWriteValueLengthForCallsCount > 0
    }
    open var maximumWriteValueLengthForReceivedType: CBCharacteristicWriteType?
    open var maximumWriteValueLengthForReturnValue: Int!
    open var maximumWriteValueLengthForClosure: ((CBCharacteristicWriteType) -> Int)?

    open func maximumWriteValueLength(for type: CBCharacteristicWriteType) -> Int {
        maximumWriteValueLengthForCallsCount += 1
        maximumWriteValueLengthForReceivedType = type
        return maximumWriteValueLengthForClosure.map({ $0(type) }) ?? maximumWriteValueLengthForReturnValue
    }

    //MARK: - writeValue

    open var writeValueForTypeCallsCount = 0
    open var writeValueForTypeCalled: Bool {
        return writeValueForTypeCallsCount > 0
    }
    open var writeValueForTypeReceivedArguments: (data: Data, characteristic: BluetoothCharacteristic, type: CBCharacteristicWriteType)?
    open var writeValueForTypeReturnValue: Promise<BluetoothCharacteristic, BluetoothError>!
    open var writeValueForTypeClosure: ((Data, BluetoothCharacteristic, CBCharacteristicWriteType) -> Promise<BluetoothCharacteristic, BluetoothError>)?

    open func writeValue(_ data: Data, for characteristic: BluetoothCharacteristic, type: CBCharacteristicWriteType) -> Promise<BluetoothCharacteristic, BluetoothError> {
        writeValueForTypeCallsCount += 1
        writeValueForTypeReceivedArguments = (data: data, characteristic: characteristic, type: type)
        return writeValueForTypeClosure.map({ $0(data, characteristic, type) }) ?? writeValueForTypeReturnValue
    }

    //MARK: - notifyValue

    open var notifyValueForCallsCount = 0
    open var notifyValueForCalled: Bool {
        return notifyValueForCallsCount > 0
    }
    open var notifyValueForReceivedCharacteristic: BluetoothCharacteristic?
    open var notifyValueForReturnValue: AnyPublisher<BluetoothCharacteristic, BluetoothError>!
    open var notifyValueForClosure: ((BluetoothCharacteristic) -> AnyPublisher<BluetoothCharacteristic, BluetoothError>)?

    open func notifyValue(for characteristic: BluetoothCharacteristic) -> AnyPublisher<BluetoothCharacteristic, BluetoothError> {
        notifyValueForCallsCount += 1
        notifyValueForReceivedCharacteristic = characteristic
        return notifyValueForClosure.map({ $0(characteristic) }) ?? notifyValueForReturnValue
    }

    //MARK: - discoverDescriptors

    open var discoverDescriptorsForCallsCount = 0
    open var discoverDescriptorsForCalled: Bool {
        return discoverDescriptorsForCallsCount > 0
    }
    open var discoverDescriptorsForReceivedCharacteristic: BluetoothCharacteristic?
    open var discoverDescriptorsForReturnValue: Promise<[BluetoothDescriptor], BluetoothError>!
    open var discoverDescriptorsForClosure: ((BluetoothCharacteristic) -> Promise<[BluetoothDescriptor], BluetoothError>)?

    open func discoverDescriptors(for characteristic: BluetoothCharacteristic) -> Promise<[BluetoothDescriptor], BluetoothError> {
        discoverDescriptorsForCallsCount += 1
        discoverDescriptorsForReceivedCharacteristic = characteristic
        return discoverDescriptorsForClosure.map({ $0(characteristic) }) ?? discoverDescriptorsForReturnValue
    }

    //MARK: - readDescriptorValue

    open var readDescriptorValueCallsCount = 0
    open var readDescriptorValueCalled: Bool {
        return readDescriptorValueCallsCount > 0
    }
    open var readDescriptorValueReceivedDescriptor: BluetoothDescriptor?
    open var readDescriptorValueReturnValue: Promise<BluetoothDescriptor, BluetoothError>!
    open var readDescriptorValueClosure: ((BluetoothDescriptor) -> Promise<BluetoothDescriptor, BluetoothError>)?

    open func readDescriptorValue(_ descriptor: BluetoothDescriptor) -> Promise<BluetoothDescriptor, BluetoothError> {
        readDescriptorValueCallsCount += 1
        readDescriptorValueReceivedDescriptor = descriptor
        return readDescriptorValueClosure.map({ $0(descriptor) }) ?? readDescriptorValueReturnValue
    }

    //MARK: - writeValue

    open var writeValueForCallsCount = 0
    open var writeValueForCalled: Bool {
        return writeValueForCallsCount > 0
    }
    open var writeValueForReceivedArguments: (data: Data, descriptor: BluetoothDescriptor)?
    open var writeValueForReturnValue: Promise<BluetoothDescriptor, BluetoothError>!
    open var writeValueForClosure: ((Data, BluetoothDescriptor) -> Promise<BluetoothDescriptor, BluetoothError>)?

    open func writeValue(_ data: Data, for descriptor: BluetoothDescriptor) -> Promise<BluetoothDescriptor, BluetoothError> {
        writeValueForCallsCount += 1
        writeValueForReceivedArguments = (data: data, descriptor: descriptor)
        return writeValueForClosure.map({ $0(data, descriptor) }) ?? writeValueForReturnValue
    }

    //MARK: - openL2CAPChannel

    open var openL2CAPChannelPSMCallsCount = 0
    open var openL2CAPChannelPSMCalled: Bool {
        return openL2CAPChannelPSMCallsCount > 0
    }
    open var openL2CAPChannelPSMReceivedPSM: CBL2CAPPSM?
    open var openL2CAPChannelPSMReturnValue: Promise<L2CAPChannel, BluetoothError>!
    open var openL2CAPChannelPSMClosure: ((CBL2CAPPSM) -> Promise<L2CAPChannel, BluetoothError>)?

    open func openL2CAPChannel(PSM: CBL2CAPPSM) -> Promise<L2CAPChannel, BluetoothError> {
        openL2CAPChannelPSMCallsCount += 1
        openL2CAPChannelPSMReceivedPSM = PSM
        return openL2CAPChannelPSMClosure.map({ $0(PSM) }) ?? openL2CAPChannelPSMReturnValue
    }

}
open class BluetoothServiceMock: BluetoothService {
    open var id: CBUUID {
        get { return underlyingId }
        set(value) { underlyingId = value }
    }
    open var underlyingId: CBUUID!
    open var peripheral: BluetoothPeripheral {
        get { return underlyingPeripheral }
        set(value) { underlyingPeripheral = value }
    }
    open var underlyingPeripheral: BluetoothPeripheral!
    open var isPrimary: Bool {
        get { return underlyingIsPrimary }
        set(value) { underlyingIsPrimary = value }
    }
    open var underlyingIsPrimary: Bool!
    open var includedServices: [BluetoothService]?
    open var characteristics: [BluetoothCharacteristic]?
}
open class CentralManagerMock: CentralManager {
    open var isScanning: AnyPublisher<Bool, Never> {
        get { return underlyingIsScanning }
        set(value) { underlyingIsScanning = value }
    }
    open var underlyingIsScanning: AnyPublisher<Bool, Never>!
    open var peripheralConnection: AnyPublisher<PeripheralConnectionEvent, Never> {
        get { return underlyingPeripheralConnection }
        set(value) { underlyingPeripheralConnection = value }
    }
    open var underlyingPeripheralConnection: AnyPublisher<PeripheralConnectionEvent, Never>!
    open var state: AnyPublisher<CBManagerState, BluetoothError> {
        get { return underlyingState }
        set(value) { underlyingState = value }
    }
    open var underlyingState: AnyPublisher<CBManagerState, BluetoothError>!
    open var stateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError> {
        get { return underlyingStateRestoration }
        set(value) { underlyingStateRestoration = value }
    }
    open var underlyingStateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError>!
    //MARK: - scanForPeripherals

    open var scanForPeripheralsCallsCount = 0
    open var scanForPeripheralsCalled: Bool {
        return scanForPeripheralsCallsCount > 0
    }
    open var scanForPeripheralsReturnValue: AnyPublisher<AdvertisingPeripheral, BluetoothError>!
    open var scanForPeripheralsClosure: (() -> AnyPublisher<AdvertisingPeripheral, BluetoothError>)?

    open func scanForPeripherals() -> AnyPublisher<AdvertisingPeripheral, BluetoothError> {
        scanForPeripheralsCallsCount += 1
        return scanForPeripheralsClosure.map({ $0() }) ?? scanForPeripheralsReturnValue
    }

    //MARK: - scanForPeripherals

    open var scanForPeripheralsWithServicesCallsCount = 0
    open var scanForPeripheralsWithServicesCalled: Bool {
        return scanForPeripheralsWithServicesCallsCount > 0
    }
    open var scanForPeripheralsWithServicesReceivedServiceUUIDs: [CBUUID]?
    open var scanForPeripheralsWithServicesReturnValue: AnyPublisher<AdvertisingPeripheral, BluetoothError>!
    open var scanForPeripheralsWithServicesClosure: (([CBUUID]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError>)?

    open func scanForPeripherals(withServices serviceUUIDs: [CBUUID]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError> {
        scanForPeripheralsWithServicesCallsCount += 1
        scanForPeripheralsWithServicesReceivedServiceUUIDs = serviceUUIDs
        return scanForPeripheralsWithServicesClosure.map({ $0(serviceUUIDs) }) ?? scanForPeripheralsWithServicesReturnValue
    }

    //MARK: - scanForPeripherals

    open var scanForPeripheralsWithServicesOptionsCallsCount = 0
    open var scanForPeripheralsWithServicesOptionsCalled: Bool {
        return scanForPeripheralsWithServicesOptionsCallsCount > 0
    }
    open var scanForPeripheralsWithServicesOptionsReceivedArguments: (serviceUUIDs: [CBUUID], options: [String: Any])?
    open var scanForPeripheralsWithServicesOptionsReturnValue: AnyPublisher<AdvertisingPeripheral, BluetoothError>!
    open var scanForPeripheralsWithServicesOptionsClosure: (([CBUUID], [String: Any]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError>)?

    open func scanForPeripherals(withServices serviceUUIDs: [CBUUID], options: [String: Any]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError> {
        scanForPeripheralsWithServicesOptionsCallsCount += 1
        scanForPeripheralsWithServicesOptionsReceivedArguments = (serviceUUIDs: serviceUUIDs, options: options)
        return scanForPeripheralsWithServicesOptionsClosure.map({ $0(serviceUUIDs, options) }) ?? scanForPeripheralsWithServicesOptionsReturnValue
    }

    //MARK: - scanForPeripherals

    open var scanForPeripheralsOptionsCallsCount = 0
    open var scanForPeripheralsOptionsCalled: Bool {
        return scanForPeripheralsOptionsCallsCount > 0
    }
    open var scanForPeripheralsOptionsReceivedOptions: [String: Any]?
    open var scanForPeripheralsOptionsReturnValue: AnyPublisher<AdvertisingPeripheral, BluetoothError>!
    open var scanForPeripheralsOptionsClosure: (([String: Any]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError>)?

    open func scanForPeripherals(options: [String: Any]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError> {
        scanForPeripheralsOptionsCallsCount += 1
        scanForPeripheralsOptionsReceivedOptions = options
        return scanForPeripheralsOptionsClosure.map({ $0(options) }) ?? scanForPeripheralsOptionsReturnValue
    }

    //MARK: - retrievePeripherals

    open var retrievePeripheralsWithIdentifiersCallsCount = 0
    open var retrievePeripheralsWithIdentifiersCalled: Bool {
        return retrievePeripheralsWithIdentifiersCallsCount > 0
    }
    open var retrievePeripheralsWithIdentifiersReceivedIdentifiers: [UUID]?
    open var retrievePeripheralsWithIdentifiersReturnValue: [BluetoothPeripheral]!
    open var retrievePeripheralsWithIdentifiersClosure: (([UUID]) -> [BluetoothPeripheral])?

    open func retrievePeripherals(withIdentifiers identifiers: [UUID]) -> [BluetoothPeripheral] {
        retrievePeripheralsWithIdentifiersCallsCount += 1
        retrievePeripheralsWithIdentifiersReceivedIdentifiers = identifiers
        return retrievePeripheralsWithIdentifiersClosure.map({ $0(identifiers) }) ?? retrievePeripheralsWithIdentifiersReturnValue
    }

    //MARK: - retrieveConnectedPeripherals

    open var retrieveConnectedPeripheralsWithServicesCallsCount = 0
    open var retrieveConnectedPeripheralsWithServicesCalled: Bool {
        return retrieveConnectedPeripheralsWithServicesCallsCount > 0
    }
    open var retrieveConnectedPeripheralsWithServicesReceivedServiceUUIDs: [CBUUID]?
    open var retrieveConnectedPeripheralsWithServicesReturnValue: [BluetoothPeripheral]!
    open var retrieveConnectedPeripheralsWithServicesClosure: (([CBUUID]) -> [BluetoothPeripheral])?

    open func retrieveConnectedPeripherals(withServices serviceUUIDs: [CBUUID]) -> [BluetoothPeripheral] {
        retrieveConnectedPeripheralsWithServicesCallsCount += 1
        retrieveConnectedPeripheralsWithServicesReceivedServiceUUIDs = serviceUUIDs
        return retrieveConnectedPeripheralsWithServicesClosure.map({ $0(serviceUUIDs) }) ?? retrieveConnectedPeripheralsWithServicesReturnValue
    }

    //MARK: - connect

    open var connectCallsCount = 0
    open var connectCalled: Bool {
        return connectCallsCount > 0
    }
    open var connectReceivedPeripheral: BluetoothPeripheral?
    open var connectReturnValue: AnyPublisher<BluetoothPeripheral, BluetoothError>!
    open var connectClosure: ((BluetoothPeripheral) -> AnyPublisher<BluetoothPeripheral, BluetoothError>)?

    open func connect(_ peripheral: BluetoothPeripheral) -> AnyPublisher<BluetoothPeripheral, BluetoothError> {
        connectCallsCount += 1
        connectReceivedPeripheral = peripheral
        return connectClosure.map({ $0(peripheral) }) ?? connectReturnValue
    }

    //MARK: - connect

    open var connectOptionsCallsCount = 0
    open var connectOptionsCalled: Bool {
        return connectOptionsCallsCount > 0
    }
    open var connectOptionsReceivedArguments: (peripheral: BluetoothPeripheral, options: [String : Any])?
    open var connectOptionsReturnValue: AnyPublisher<BluetoothPeripheral, BluetoothError>!
    open var connectOptionsClosure: ((BluetoothPeripheral, [String : Any]) -> AnyPublisher<BluetoothPeripheral, BluetoothError>)?

    open func connect(_ peripheral: BluetoothPeripheral, options: [String : Any]) -> AnyPublisher<BluetoothPeripheral, BluetoothError> {
        connectOptionsCallsCount += 1
        connectOptionsReceivedArguments = (peripheral: peripheral, options: options)
        return connectOptionsClosure.map({ $0(peripheral, options) }) ?? connectOptionsReturnValue
    }

}
open class L2CAPChannelMock: L2CAPChannel {
    open var peer: BluetoothPeer {
        get { return underlyingPeer }
        set(value) { underlyingPeer = value }
    }
    open var underlyingPeer: BluetoothPeer!
    open var inputStream: InputStream {
        get { return underlyingInputStream }
        set(value) { underlyingInputStream = value }
    }
    open var underlyingInputStream: InputStream!
    open var outputStream: OutputStream {
        get { return underlyingOutputStream }
        set(value) { underlyingOutputStream = value }
    }
    open var underlyingOutputStream: OutputStream!
    open var psm: CBL2CAPPSM {
        get { return underlyingPsm }
        set(value) { underlyingPsm = value }
    }
    open var underlyingPsm: CBL2CAPPSM!
}
open class PeripheralManagerMock: PeripheralManager {
    open var isAdvertising: AnyPublisher<Bool, Never> {
        get { return underlyingIsAdvertising }
        set(value) { underlyingIsAdvertising = value }
    }
    open var underlyingIsAdvertising: AnyPublisher<Bool, Never>!
    open var isReadyAgainForWriteWithoutResponse: AnyPublisher<Void, Never> {
        get { return underlyingIsReadyAgainForWriteWithoutResponse }
        set(value) { underlyingIsReadyAgainForWriteWithoutResponse = value }
    }
    open var underlyingIsReadyAgainForWriteWithoutResponse: AnyPublisher<Void, Never>!
    open var state: AnyPublisher<CBManagerState, BluetoothError> {
        get { return underlyingState }
        set(value) { underlyingState = value }
    }
    open var underlyingState: AnyPublisher<CBManagerState, BluetoothError>!
    open var stateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError> {
        get { return underlyingStateRestoration }
        set(value) { underlyingStateRestoration = value }
    }
    open var underlyingStateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError>!
    //MARK: - startAdvertising

    open var startAdvertisingCallsCount = 0
    open var startAdvertisingCalled: Bool {
        return startAdvertisingCallsCount > 0
    }
    open var startAdvertisingReturnValue: AnyPublisher<Void, BluetoothError>!
    open var startAdvertisingClosure: (() -> AnyPublisher<Void, BluetoothError>)?

    open func startAdvertising() -> AnyPublisher<Void, BluetoothError> {
        startAdvertisingCallsCount += 1
        return startAdvertisingClosure.map({ $0() }) ?? startAdvertisingReturnValue
    }

    //MARK: - startAdvertising

    open var startAdvertisingAdvertisementDataCallsCount = 0
    open var startAdvertisingAdvertisementDataCalled: Bool {
        return startAdvertisingAdvertisementDataCallsCount > 0
    }
    open var startAdvertisingAdvertisementDataReceivedAdvertisementData: [String: Any]?
    open var startAdvertisingAdvertisementDataReturnValue: AnyPublisher<Void, BluetoothError>!
    open var startAdvertisingAdvertisementDataClosure: (([String: Any]) -> AnyPublisher<Void, BluetoothError>)?

    open func startAdvertising(advertisementData: [String: Any]) -> AnyPublisher<Void, BluetoothError> {
        startAdvertisingAdvertisementDataCallsCount += 1
        startAdvertisingAdvertisementDataReceivedAdvertisementData = advertisementData
        return startAdvertisingAdvertisementDataClosure.map({ $0(advertisementData) }) ?? startAdvertisingAdvertisementDataReturnValue
    }

    //MARK: - setDesiredConnectionLatency

    open var setDesiredConnectionLatencyForCallsCount = 0
    open var setDesiredConnectionLatencyForCalled: Bool {
        return setDesiredConnectionLatencyForCallsCount > 0
    }
    open var setDesiredConnectionLatencyForReceivedArguments: (latency: CBPeripheralManagerConnectionLatency, central: BluetoothCentral)?
    open var setDesiredConnectionLatencyForReturnValue: Result<Void, BluetoothError>!
    open var setDesiredConnectionLatencyForClosure: ((CBPeripheralManagerConnectionLatency, BluetoothCentral) -> Result<Void, BluetoothError>)?

    open func setDesiredConnectionLatency(_ latency: CBPeripheralManagerConnectionLatency, for central: BluetoothCentral) -> Result<Void, BluetoothError> {
        setDesiredConnectionLatencyForCallsCount += 1
        setDesiredConnectionLatencyForReceivedArguments = (latency: latency, central: central)
        return setDesiredConnectionLatencyForClosure.map({ $0(latency, central) }) ?? setDesiredConnectionLatencyForReturnValue
    }

    //MARK: - add

    open var addCallsCount = 0
    open var addCalled: Bool {
        return addCallsCount > 0
    }
    open var addReceivedService: BluetoothService?
    open var addReturnValue: Promise<BluetoothService, BluetoothError>!
    open var addClosure: ((BluetoothService) -> Promise<BluetoothService, BluetoothError>)?

    open func add(_ service: BluetoothService) -> Promise<BluetoothService, BluetoothError> {
        addCallsCount += 1
        addReceivedService = service
        return addClosure.map({ $0(service) }) ?? addReturnValue
    }

    //MARK: - remove

    open var removeCallsCount = 0
    open var removeCalled: Bool {
        return removeCallsCount > 0
    }
    open var removeReceivedService: BluetoothService?
    open var removeReturnValue: Result<BluetoothService, BluetoothError>!
    open var removeClosure: ((BluetoothService) -> Result<BluetoothService, BluetoothError>)?

    open func remove(_ service: BluetoothService) -> Result<BluetoothService, BluetoothError> {
        removeCallsCount += 1
        removeReceivedService = service
        return removeClosure.map({ $0(service) }) ?? removeReturnValue
    }

    //MARK: - removeAllServices

    open var removeAllServicesCallsCount = 0
    open var removeAllServicesCalled: Bool {
        return removeAllServicesCallsCount > 0
    }
    open var removeAllServicesClosure: (() -> Void)?

    open func removeAllServices() {
        removeAllServicesCallsCount += 1
        removeAllServicesClosure?()
    }

    //MARK: - respond

    open var respondToWithResultCallsCount = 0
    open var respondToWithResultCalled: Bool {
        return respondToWithResultCallsCount > 0
    }
    open var respondToWithResultReceivedArguments: (request: ATTRequest, result: CBATTError.Code)?
    open var respondToWithResultReturnValue: Result<Void, BluetoothError>!
    open var respondToWithResultClosure: ((ATTRequest, CBATTError.Code) -> Result<Void, BluetoothError>)?

    open func respond(to request: ATTRequest, withResult result: CBATTError.Code) -> Result<Void, BluetoothError> {
        respondToWithResultCallsCount += 1
        respondToWithResultReceivedArguments = (request: request, result: result)
        return respondToWithResultClosure.map({ $0(request, result) }) ?? respondToWithResultReturnValue
    }

    //MARK: - updateValue

    open var updateValueForOnSubscribedCentralsCallsCount = 0
    open var updateValueForOnSubscribedCentralsCalled: Bool {
        return updateValueForOnSubscribedCentralsCallsCount > 0
    }
    open var updateValueForOnSubscribedCentralsReceivedArguments: (value: Data, characteristic: BluetoothCharacteristic, centrals: [BluetoothCentral]?)?
    open var updateValueForOnSubscribedCentralsReturnValue: Result<Bool, BluetoothError>!
    open var updateValueForOnSubscribedCentralsClosure: ((Data, BluetoothCharacteristic, [BluetoothCentral]?) -> Result<Bool, BluetoothError>)?

    open func updateValue(_ value: Data, for characteristic: BluetoothCharacteristic, onSubscribedCentrals centrals: [BluetoothCentral]?) -> Result<Bool, BluetoothError> {
        updateValueForOnSubscribedCentralsCallsCount += 1
        updateValueForOnSubscribedCentralsReceivedArguments = (value: value, characteristic: characteristic, centrals: centrals)
        return updateValueForOnSubscribedCentralsClosure.map({ $0(value, characteristic, centrals) }) ?? updateValueForOnSubscribedCentralsReturnValue
    }

    //MARK: - publishL2CAPChannel

    open var publishL2CAPChannelWithEncryptionCallsCount = 0
    open var publishL2CAPChannelWithEncryptionCalled: Bool {
        return publishL2CAPChannelWithEncryptionCallsCount > 0
    }
    open var publishL2CAPChannelWithEncryptionReceivedEncryptionRequired: Bool?
    open var publishL2CAPChannelWithEncryptionReturnValue: Promise<CBL2CAPPSM, BluetoothError>!
    open var publishL2CAPChannelWithEncryptionClosure: ((Bool) -> Promise<CBL2CAPPSM, BluetoothError>)?

    open func publishL2CAPChannel(withEncryption encryptionRequired: Bool) -> Promise<CBL2CAPPSM, BluetoothError> {
        publishL2CAPChannelWithEncryptionCallsCount += 1
        publishL2CAPChannelWithEncryptionReceivedEncryptionRequired = encryptionRequired
        return publishL2CAPChannelWithEncryptionClosure.map({ $0(encryptionRequired) }) ?? publishL2CAPChannelWithEncryptionReturnValue
    }

    //MARK: - unpublishL2CAPChannel

    open var unpublishL2CAPChannelCallsCount = 0
    open var unpublishL2CAPChannelCalled: Bool {
        return unpublishL2CAPChannelCallsCount > 0
    }
    open var unpublishL2CAPChannelReceivedPSM: CBL2CAPPSM?
    open var unpublishL2CAPChannelReturnValue: Promise<CBL2CAPPSM, BluetoothError>!
    open var unpublishL2CAPChannelClosure: ((CBL2CAPPSM) -> Promise<CBL2CAPPSM, BluetoothError>)?

    open func unpublishL2CAPChannel(_ PSM: CBL2CAPPSM) -> Promise<CBL2CAPPSM, BluetoothError> {
        unpublishL2CAPChannelCallsCount += 1
        unpublishL2CAPChannelReceivedPSM = PSM
        return unpublishL2CAPChannelClosure.map({ $0(PSM) }) ?? unpublishL2CAPChannelReturnValue
    }

}

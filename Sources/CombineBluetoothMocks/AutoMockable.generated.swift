// Generated using Sourcery 2.2.4 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

import Combine
import CombineBluetooth
import CoreBluetooth























public class ATTRequestMock: ATTRequest {

    public init() {}

    public var central: BluetoothCentral {
        get { return underlyingCentral }
        set(value) { underlyingCentral = value }
    }
    public var underlyingCentral: (BluetoothCentral)!
    public var characteristic: BluetoothCharacteristic {
        get { return underlyingCharacteristic }
        set(value) { underlyingCharacteristic = value }
    }
    public var underlyingCharacteristic: (BluetoothCharacteristic)!
    public var offset: Int {
        get { return underlyingOffset }
        set(value) { underlyingOffset = value }
    }
    public var underlyingOffset: (Int)!
    public var value: Data?



}
public class AdvertisingPeripheralMock: AdvertisingPeripheral {

    public init() {}

    public var advertisementData: [String: Any] = [:]
    public var rssi: NSNumber {
        get { return underlyingRssi }
        set(value) { underlyingRssi = value }
    }
    public var underlyingRssi: (NSNumber)!
    public var peripheral: BluetoothPeripheral {
        get { return underlyingPeripheral }
        set(value) { underlyingPeripheral = value }
    }
    public var underlyingPeripheral: (BluetoothPeripheral)!



}
public class BluetoothCentralMock: BluetoothCentral {

    public init() {}

    public var maximumUpdateValueLength: Int {
        get { return underlyingMaximumUpdateValueLength }
        set(value) { underlyingMaximumUpdateValueLength = value }
    }
    public var underlyingMaximumUpdateValueLength: (Int)!
    public var id: UUID {
        get { return underlyingId }
        set(value) { underlyingId = value }
    }
    public var underlyingId: (UUID)!



}
public class BluetoothCharacteristicMock: BluetoothCharacteristic {

    public init() {}

    public var id: CBUUID {
        get { return underlyingId }
        set(value) { underlyingId = value }
    }
    public var underlyingId: (CBUUID)!
    public var service: BluetoothService?
    public var properties: CBCharacteristicProperties {
        get { return underlyingProperties }
        set(value) { underlyingProperties = value }
    }
    public var underlyingProperties: (CBCharacteristicProperties)!
    public var value: Data?
    public var descriptors: [BluetoothDescriptor]?
    public var isNotifying: Bool {
        get { return underlyingIsNotifying }
        set(value) { underlyingIsNotifying = value }
    }
    public var underlyingIsNotifying: (Bool)!
    public var permissions: CBAttributePermissions?
    public var subscribedCentrals: [BluetoothCentral]?



}
public class BluetoothDescriptorMock: BluetoothDescriptor {

    public init() {}

    public var id: CBUUID {
        get { return underlyingId }
        set(value) { underlyingId = value }
    }
    public var underlyingId: (CBUUID)!
    public var characteristic: BluetoothCharacteristic?
    public var value: Any?



}
public class BluetoothManagerMock: BluetoothManager {

    public init() {}

    public var state: AnyPublisher<CBManagerState, BluetoothError> {
        get { return underlyingState }
        set(value) { underlyingState = value }
    }
    public var underlyingState: (AnyPublisher<CBManagerState, BluetoothError>)!
    public var stateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError> {
        get { return underlyingStateRestoration }
        set(value) { underlyingStateRestoration = value }
    }
    public var underlyingStateRestoration: (AnyPublisher<StateRestorationEvent, BluetoothError>)!



}
public class BluetoothPeerMock: BluetoothPeer {

    public init() {}

    public var id: UUID {
        get { return underlyingId }
        set(value) { underlyingId = value }
    }
    public var underlyingId: (UUID)!



}
public class BluetoothPeripheralMock: BluetoothPeripheral {

    public init() {}

    public var name: String?
    public var state: CBPeripheralState {
        get { return underlyingState }
        set(value) { underlyingState = value }
    }
    public var underlyingState: (CBPeripheralState)!
    public var services: [BluetoothService]?
    public var canSendWriteWithoutResponse: Bool {
        get { return underlyingCanSendWriteWithoutResponse }
        set(value) { underlyingCanSendWriteWithoutResponse = value }
    }
    public var underlyingCanSendWriteWithoutResponse: (Bool)!
    public var isReadyAgainForWriteWithoutResponse: AnyPublisher<Void, Never> {
        get { return underlyingIsReadyAgainForWriteWithoutResponse }
        set(value) { underlyingIsReadyAgainForWriteWithoutResponse = value }
    }
    public var underlyingIsReadyAgainForWriteWithoutResponse: (AnyPublisher<Void, Never>)!
    public var proxyDelegate: CBPeripheralDelegate?
    public var id: UUID {
        get { return underlyingId }
        set(value) { underlyingId = value }
    }
    public var underlyingId: (UUID)!


    //MARK: - readRSSI

    public var readRSSIAnyPublisherNSNumberBluetoothErrorCallsCount = 0
    public var readRSSIAnyPublisherNSNumberBluetoothErrorCalled: Bool {
        return readRSSIAnyPublisherNSNumberBluetoothErrorCallsCount > 0
    }
    public var readRSSIAnyPublisherNSNumberBluetoothErrorReturnValue: AnyPublisher<NSNumber, BluetoothError>!
    public var readRSSIAnyPublisherNSNumberBluetoothErrorClosure: (() -> AnyPublisher<NSNumber, BluetoothError>)?

    public func readRSSI() -> AnyPublisher<NSNumber, BluetoothError> {
        readRSSIAnyPublisherNSNumberBluetoothErrorCallsCount += 1
        if let readRSSIAnyPublisherNSNumberBluetoothErrorClosure = readRSSIAnyPublisherNSNumberBluetoothErrorClosure {
            return readRSSIAnyPublisherNSNumberBluetoothErrorClosure()
        } else {
            return readRSSIAnyPublisherNSNumberBluetoothErrorReturnValue
        }
    }

    //MARK: - discoverServices

    public var discoverServicesServiceUUIDsCBUUIDAnyPublisherBluetoothServiceBluetoothErrorCallsCount = 0
    public var discoverServicesServiceUUIDsCBUUIDAnyPublisherBluetoothServiceBluetoothErrorCalled: Bool {
        return discoverServicesServiceUUIDsCBUUIDAnyPublisherBluetoothServiceBluetoothErrorCallsCount > 0
    }
    public var discoverServicesServiceUUIDsCBUUIDAnyPublisherBluetoothServiceBluetoothErrorReceivedServiceUUIDs: ([CBUUID])?
    public var discoverServicesServiceUUIDsCBUUIDAnyPublisherBluetoothServiceBluetoothErrorReceivedInvocations: [([CBUUID])?] = []
    public var discoverServicesServiceUUIDsCBUUIDAnyPublisherBluetoothServiceBluetoothErrorReturnValue: AnyPublisher<BluetoothService, BluetoothError>!
    public var discoverServicesServiceUUIDsCBUUIDAnyPublisherBluetoothServiceBluetoothErrorClosure: (([CBUUID]?) -> AnyPublisher<BluetoothService, BluetoothError>)?

    public func discoverServices(_ serviceUUIDs: [CBUUID]?) -> AnyPublisher<BluetoothService, BluetoothError> {
        discoverServicesServiceUUIDsCBUUIDAnyPublisherBluetoothServiceBluetoothErrorCallsCount += 1
        discoverServicesServiceUUIDsCBUUIDAnyPublisherBluetoothServiceBluetoothErrorReceivedServiceUUIDs = serviceUUIDs
        discoverServicesServiceUUIDsCBUUIDAnyPublisherBluetoothServiceBluetoothErrorReceivedInvocations.append(serviceUUIDs)
        if let discoverServicesServiceUUIDsCBUUIDAnyPublisherBluetoothServiceBluetoothErrorClosure = discoverServicesServiceUUIDsCBUUIDAnyPublisherBluetoothServiceBluetoothErrorClosure {
            return discoverServicesServiceUUIDsCBUUIDAnyPublisherBluetoothServiceBluetoothErrorClosure(serviceUUIDs)
        } else {
            return discoverServicesServiceUUIDsCBUUIDAnyPublisherBluetoothServiceBluetoothErrorReturnValue
        }
    }

    //MARK: - discoverIncludedServices

    public var discoverIncludedServicesIncludedServiceUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorCallsCount = 0
    public var discoverIncludedServicesIncludedServiceUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorCalled: Bool {
        return discoverIncludedServicesIncludedServiceUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorCallsCount > 0
    }
    public var discoverIncludedServicesIncludedServiceUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorReceivedArguments: (includedServiceUUIDs: [CBUUID]?, service: BluetoothService)?
    public var discoverIncludedServicesIncludedServiceUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorReceivedInvocations: [(includedServiceUUIDs: [CBUUID]?, service: BluetoothService)] = []
    public var discoverIncludedServicesIncludedServiceUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorReturnValue: AnyPublisher<BluetoothService, BluetoothError>!
    public var discoverIncludedServicesIncludedServiceUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorClosure: (([CBUUID]?, BluetoothService) -> AnyPublisher<BluetoothService, BluetoothError>)?

    public func discoverIncludedServices(_ includedServiceUUIDs: [CBUUID]?, for service: BluetoothService) -> AnyPublisher<BluetoothService, BluetoothError> {
        discoverIncludedServicesIncludedServiceUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorCallsCount += 1
        discoverIncludedServicesIncludedServiceUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorReceivedArguments = (includedServiceUUIDs: includedServiceUUIDs, service: service)
        discoverIncludedServicesIncludedServiceUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorReceivedInvocations.append((includedServiceUUIDs: includedServiceUUIDs, service: service))
        if let discoverIncludedServicesIncludedServiceUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorClosure = discoverIncludedServicesIncludedServiceUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorClosure {
            return discoverIncludedServicesIncludedServiceUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorClosure(includedServiceUUIDs, service)
        } else {
            return discoverIncludedServicesIncludedServiceUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorReturnValue
        }
    }

    //MARK: - discoverCharacteristics

    public var discoverCharacteristicsCharacteristicUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothCharacteristicBluetoothErrorCallsCount = 0
    public var discoverCharacteristicsCharacteristicUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothCharacteristicBluetoothErrorCalled: Bool {
        return discoverCharacteristicsCharacteristicUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothCharacteristicBluetoothErrorCallsCount > 0
    }
    public var discoverCharacteristicsCharacteristicUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothCharacteristicBluetoothErrorReceivedArguments: (characteristicUUIDs: [CBUUID]?, service: BluetoothService)?
    public var discoverCharacteristicsCharacteristicUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothCharacteristicBluetoothErrorReceivedInvocations: [(characteristicUUIDs: [CBUUID]?, service: BluetoothService)] = []
    public var discoverCharacteristicsCharacteristicUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothCharacteristicBluetoothErrorReturnValue: AnyPublisher<BluetoothCharacteristic, BluetoothError>!
    public var discoverCharacteristicsCharacteristicUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothCharacteristicBluetoothErrorClosure: (([CBUUID]?, BluetoothService) -> AnyPublisher<BluetoothCharacteristic, BluetoothError>)?

    public func discoverCharacteristics(_ characteristicUUIDs: [CBUUID]?, for service: BluetoothService) -> AnyPublisher<BluetoothCharacteristic, BluetoothError> {
        discoverCharacteristicsCharacteristicUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothCharacteristicBluetoothErrorCallsCount += 1
        discoverCharacteristicsCharacteristicUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothCharacteristicBluetoothErrorReceivedArguments = (characteristicUUIDs: characteristicUUIDs, service: service)
        discoverCharacteristicsCharacteristicUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothCharacteristicBluetoothErrorReceivedInvocations.append((characteristicUUIDs: characteristicUUIDs, service: service))
        if let discoverCharacteristicsCharacteristicUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothCharacteristicBluetoothErrorClosure = discoverCharacteristicsCharacteristicUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothCharacteristicBluetoothErrorClosure {
            return discoverCharacteristicsCharacteristicUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothCharacteristicBluetoothErrorClosure(characteristicUUIDs, service)
        } else {
            return discoverCharacteristicsCharacteristicUUIDsCBUUIDForServiceBluetoothServiceAnyPublisherBluetoothCharacteristicBluetoothErrorReturnValue
        }
    }

    //MARK: - readCharacteristicValue

    public var readCharacteristicValueCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorCallsCount = 0
    public var readCharacteristicValueCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorCalled: Bool {
        return readCharacteristicValueCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorCallsCount > 0
    }
    public var readCharacteristicValueCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorReceivedCharacteristic: (BluetoothCharacteristic)?
    public var readCharacteristicValueCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorReceivedInvocations: [(BluetoothCharacteristic)] = []
    public var readCharacteristicValueCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorReturnValue: AnyPublisher<BluetoothCharacteristic, BluetoothError>!
    public var readCharacteristicValueCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorClosure: ((BluetoothCharacteristic) -> AnyPublisher<BluetoothCharacteristic, BluetoothError>)?

    public func readCharacteristicValue(_ characteristic: BluetoothCharacteristic) -> AnyPublisher<BluetoothCharacteristic, BluetoothError> {
        readCharacteristicValueCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorCallsCount += 1
        readCharacteristicValueCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorReceivedCharacteristic = characteristic
        readCharacteristicValueCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorReceivedInvocations.append(characteristic)
        if let readCharacteristicValueCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorClosure = readCharacteristicValueCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorClosure {
            return readCharacteristicValueCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorClosure(characteristic)
        } else {
            return readCharacteristicValueCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorReturnValue
        }
    }

    //MARK: - maximumWriteValueLength

    public var maximumWriteValueLengthForTypeCBCharacteristicWriteTypeIntCallsCount = 0
    public var maximumWriteValueLengthForTypeCBCharacteristicWriteTypeIntCalled: Bool {
        return maximumWriteValueLengthForTypeCBCharacteristicWriteTypeIntCallsCount > 0
    }
    public var maximumWriteValueLengthForTypeCBCharacteristicWriteTypeIntReceivedType: (CBCharacteristicWriteType)?
    public var maximumWriteValueLengthForTypeCBCharacteristicWriteTypeIntReceivedInvocations: [(CBCharacteristicWriteType)] = []
    public var maximumWriteValueLengthForTypeCBCharacteristicWriteTypeIntReturnValue: Int!
    public var maximumWriteValueLengthForTypeCBCharacteristicWriteTypeIntClosure: ((CBCharacteristicWriteType) -> Int)?

    public func maximumWriteValueLength(for type: CBCharacteristicWriteType) -> Int {
        maximumWriteValueLengthForTypeCBCharacteristicWriteTypeIntCallsCount += 1
        maximumWriteValueLengthForTypeCBCharacteristicWriteTypeIntReceivedType = type
        maximumWriteValueLengthForTypeCBCharacteristicWriteTypeIntReceivedInvocations.append(type)
        if let maximumWriteValueLengthForTypeCBCharacteristicWriteTypeIntClosure = maximumWriteValueLengthForTypeCBCharacteristicWriteTypeIntClosure {
            return maximumWriteValueLengthForTypeCBCharacteristicWriteTypeIntClosure(type)
        } else {
            return maximumWriteValueLengthForTypeCBCharacteristicWriteTypeIntReturnValue
        }
    }

    //MARK: - writeValue

    public var writeValueDataDataForCharacteristicBluetoothCharacteristicTypeCBCharacteristicWriteTypeAnyPublisherBluetoothCharacteristicBluetoothErrorCallsCount = 0
    public var writeValueDataDataForCharacteristicBluetoothCharacteristicTypeCBCharacteristicWriteTypeAnyPublisherBluetoothCharacteristicBluetoothErrorCalled: Bool {
        return writeValueDataDataForCharacteristicBluetoothCharacteristicTypeCBCharacteristicWriteTypeAnyPublisherBluetoothCharacteristicBluetoothErrorCallsCount > 0
    }
    public var writeValueDataDataForCharacteristicBluetoothCharacteristicTypeCBCharacteristicWriteTypeAnyPublisherBluetoothCharacteristicBluetoothErrorReceivedArguments: (data: Data, characteristic: BluetoothCharacteristic, type: CBCharacteristicWriteType)?
    public var writeValueDataDataForCharacteristicBluetoothCharacteristicTypeCBCharacteristicWriteTypeAnyPublisherBluetoothCharacteristicBluetoothErrorReceivedInvocations: [(data: Data, characteristic: BluetoothCharacteristic, type: CBCharacteristicWriteType)] = []
    public var writeValueDataDataForCharacteristicBluetoothCharacteristicTypeCBCharacteristicWriteTypeAnyPublisherBluetoothCharacteristicBluetoothErrorReturnValue: AnyPublisher<BluetoothCharacteristic, BluetoothError>!
    public var writeValueDataDataForCharacteristicBluetoothCharacteristicTypeCBCharacteristicWriteTypeAnyPublisherBluetoothCharacteristicBluetoothErrorClosure: ((Data, BluetoothCharacteristic, CBCharacteristicWriteType) -> AnyPublisher<BluetoothCharacteristic, BluetoothError>)?

    public func writeValue(_ data: Data, for characteristic: BluetoothCharacteristic, type: CBCharacteristicWriteType) -> AnyPublisher<BluetoothCharacteristic, BluetoothError> {
        writeValueDataDataForCharacteristicBluetoothCharacteristicTypeCBCharacteristicWriteTypeAnyPublisherBluetoothCharacteristicBluetoothErrorCallsCount += 1
        writeValueDataDataForCharacteristicBluetoothCharacteristicTypeCBCharacteristicWriteTypeAnyPublisherBluetoothCharacteristicBluetoothErrorReceivedArguments = (data: data, characteristic: characteristic, type: type)
        writeValueDataDataForCharacteristicBluetoothCharacteristicTypeCBCharacteristicWriteTypeAnyPublisherBluetoothCharacteristicBluetoothErrorReceivedInvocations.append((data: data, characteristic: characteristic, type: type))
        if let writeValueDataDataForCharacteristicBluetoothCharacteristicTypeCBCharacteristicWriteTypeAnyPublisherBluetoothCharacteristicBluetoothErrorClosure = writeValueDataDataForCharacteristicBluetoothCharacteristicTypeCBCharacteristicWriteTypeAnyPublisherBluetoothCharacteristicBluetoothErrorClosure {
            return writeValueDataDataForCharacteristicBluetoothCharacteristicTypeCBCharacteristicWriteTypeAnyPublisherBluetoothCharacteristicBluetoothErrorClosure(data, characteristic, type)
        } else {
            return writeValueDataDataForCharacteristicBluetoothCharacteristicTypeCBCharacteristicWriteTypeAnyPublisherBluetoothCharacteristicBluetoothErrorReturnValue
        }
    }

    //MARK: - notifyValue

    public var notifyValueForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorCallsCount = 0
    public var notifyValueForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorCalled: Bool {
        return notifyValueForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorCallsCount > 0
    }
    public var notifyValueForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorReceivedCharacteristic: (BluetoothCharacteristic)?
    public var notifyValueForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorReceivedInvocations: [(BluetoothCharacteristic)] = []
    public var notifyValueForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorReturnValue: AnyPublisher<BluetoothCharacteristic, BluetoothError>!
    public var notifyValueForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorClosure: ((BluetoothCharacteristic) -> AnyPublisher<BluetoothCharacteristic, BluetoothError>)?

    public func notifyValue(for characteristic: BluetoothCharacteristic) -> AnyPublisher<BluetoothCharacteristic, BluetoothError> {
        notifyValueForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorCallsCount += 1
        notifyValueForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorReceivedCharacteristic = characteristic
        notifyValueForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorReceivedInvocations.append(characteristic)
        if let notifyValueForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorClosure = notifyValueForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorClosure {
            return notifyValueForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorClosure(characteristic)
        } else {
            return notifyValueForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothCharacteristicBluetoothErrorReturnValue
        }
    }

    //MARK: - discoverDescriptors

    public var discoverDescriptorsForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothDescriptorBluetoothErrorCallsCount = 0
    public var discoverDescriptorsForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothDescriptorBluetoothErrorCalled: Bool {
        return discoverDescriptorsForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothDescriptorBluetoothErrorCallsCount > 0
    }
    public var discoverDescriptorsForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothDescriptorBluetoothErrorReceivedCharacteristic: (BluetoothCharacteristic)?
    public var discoverDescriptorsForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothDescriptorBluetoothErrorReceivedInvocations: [(BluetoothCharacteristic)] = []
    public var discoverDescriptorsForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothDescriptorBluetoothErrorReturnValue: AnyPublisher<BluetoothDescriptor, BluetoothError>!
    public var discoverDescriptorsForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothDescriptorBluetoothErrorClosure: ((BluetoothCharacteristic) -> AnyPublisher<BluetoothDescriptor, BluetoothError>)?

    public func discoverDescriptors(for characteristic: BluetoothCharacteristic) -> AnyPublisher<BluetoothDescriptor, BluetoothError> {
        discoverDescriptorsForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothDescriptorBluetoothErrorCallsCount += 1
        discoverDescriptorsForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothDescriptorBluetoothErrorReceivedCharacteristic = characteristic
        discoverDescriptorsForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothDescriptorBluetoothErrorReceivedInvocations.append(characteristic)
        if let discoverDescriptorsForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothDescriptorBluetoothErrorClosure = discoverDescriptorsForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothDescriptorBluetoothErrorClosure {
            return discoverDescriptorsForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothDescriptorBluetoothErrorClosure(characteristic)
        } else {
            return discoverDescriptorsForCharacteristicBluetoothCharacteristicAnyPublisherBluetoothDescriptorBluetoothErrorReturnValue
        }
    }

    //MARK: - readDescriptorValue

    public var readDescriptorValueDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorCallsCount = 0
    public var readDescriptorValueDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorCalled: Bool {
        return readDescriptorValueDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorCallsCount > 0
    }
    public var readDescriptorValueDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorReceivedDescriptor: (BluetoothDescriptor)?
    public var readDescriptorValueDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorReceivedInvocations: [(BluetoothDescriptor)] = []
    public var readDescriptorValueDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorReturnValue: AnyPublisher<BluetoothDescriptor, BluetoothError>!
    public var readDescriptorValueDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorClosure: ((BluetoothDescriptor) -> AnyPublisher<BluetoothDescriptor, BluetoothError>)?

    public func readDescriptorValue(_ descriptor: BluetoothDescriptor) -> AnyPublisher<BluetoothDescriptor, BluetoothError> {
        readDescriptorValueDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorCallsCount += 1
        readDescriptorValueDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorReceivedDescriptor = descriptor
        readDescriptorValueDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorReceivedInvocations.append(descriptor)
        if let readDescriptorValueDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorClosure = readDescriptorValueDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorClosure {
            return readDescriptorValueDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorClosure(descriptor)
        } else {
            return readDescriptorValueDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorReturnValue
        }
    }

    //MARK: - writeValue

    public var writeValueDataDataForDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorCallsCount = 0
    public var writeValueDataDataForDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorCalled: Bool {
        return writeValueDataDataForDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorCallsCount > 0
    }
    public var writeValueDataDataForDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorReceivedArguments: (data: Data, descriptor: BluetoothDescriptor)?
    public var writeValueDataDataForDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorReceivedInvocations: [(data: Data, descriptor: BluetoothDescriptor)] = []
    public var writeValueDataDataForDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorReturnValue: AnyPublisher<BluetoothDescriptor, BluetoothError>!
    public var writeValueDataDataForDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorClosure: ((Data, BluetoothDescriptor) -> AnyPublisher<BluetoothDescriptor, BluetoothError>)?

    public func writeValue(_ data: Data, for descriptor: BluetoothDescriptor) -> AnyPublisher<BluetoothDescriptor, BluetoothError> {
        writeValueDataDataForDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorCallsCount += 1
        writeValueDataDataForDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorReceivedArguments = (data: data, descriptor: descriptor)
        writeValueDataDataForDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorReceivedInvocations.append((data: data, descriptor: descriptor))
        if let writeValueDataDataForDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorClosure = writeValueDataDataForDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorClosure {
            return writeValueDataDataForDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorClosure(data, descriptor)
        } else {
            return writeValueDataDataForDescriptorBluetoothDescriptorAnyPublisherBluetoothDescriptorBluetoothErrorReturnValue
        }
    }

    //MARK: - openL2CAPChannel

    public var openL2CAPChannelPSMCBL2CAPPSMAnyPublisherL2CAPChannelBluetoothErrorCallsCount = 0
    public var openL2CAPChannelPSMCBL2CAPPSMAnyPublisherL2CAPChannelBluetoothErrorCalled: Bool {
        return openL2CAPChannelPSMCBL2CAPPSMAnyPublisherL2CAPChannelBluetoothErrorCallsCount > 0
    }
    public var openL2CAPChannelPSMCBL2CAPPSMAnyPublisherL2CAPChannelBluetoothErrorReceivedPSM: (CBL2CAPPSM)?
    public var openL2CAPChannelPSMCBL2CAPPSMAnyPublisherL2CAPChannelBluetoothErrorReceivedInvocations: [(CBL2CAPPSM)] = []
    public var openL2CAPChannelPSMCBL2CAPPSMAnyPublisherL2CAPChannelBluetoothErrorReturnValue: AnyPublisher<L2CAPChannel, BluetoothError>!
    public var openL2CAPChannelPSMCBL2CAPPSMAnyPublisherL2CAPChannelBluetoothErrorClosure: ((CBL2CAPPSM) -> AnyPublisher<L2CAPChannel, BluetoothError>)?

    public func openL2CAPChannel(PSM: CBL2CAPPSM) -> AnyPublisher<L2CAPChannel, BluetoothError> {
        openL2CAPChannelPSMCBL2CAPPSMAnyPublisherL2CAPChannelBluetoothErrorCallsCount += 1
        openL2CAPChannelPSMCBL2CAPPSMAnyPublisherL2CAPChannelBluetoothErrorReceivedPSM = PSM
        openL2CAPChannelPSMCBL2CAPPSMAnyPublisherL2CAPChannelBluetoothErrorReceivedInvocations.append(PSM)
        if let openL2CAPChannelPSMCBL2CAPPSMAnyPublisherL2CAPChannelBluetoothErrorClosure = openL2CAPChannelPSMCBL2CAPPSMAnyPublisherL2CAPChannelBluetoothErrorClosure {
            return openL2CAPChannelPSMCBL2CAPPSMAnyPublisherL2CAPChannelBluetoothErrorClosure(PSM)
        } else {
            return openL2CAPChannelPSMCBL2CAPPSMAnyPublisherL2CAPChannelBluetoothErrorReturnValue
        }
    }


}
public class BluetoothServiceMock: BluetoothService {

    public init() {}

    public var id: CBUUID {
        get { return underlyingId }
        set(value) { underlyingId = value }
    }
    public var underlyingId: (CBUUID)!
    public var peripheral: UUID?
    public var isPrimary: Bool {
        get { return underlyingIsPrimary }
        set(value) { underlyingIsPrimary = value }
    }
    public var underlyingIsPrimary: (Bool)!
    public var includedServices: [BluetoothService]?
    public var characteristics: [BluetoothCharacteristic]?



}
public class CentralManagerMock: CentralManager {

    public init() {}

    public var isScanning: AnyPublisher<Bool, Never> {
        get { return underlyingIsScanning }
        set(value) { underlyingIsScanning = value }
    }
    public var underlyingIsScanning: (AnyPublisher<Bool, Never>)!
    public var peripheralConnection: AnyPublisher<PeripheralConnectionEvent, Never> {
        get { return underlyingPeripheralConnection }
        set(value) { underlyingPeripheralConnection = value }
    }
    public var underlyingPeripheralConnection: (AnyPublisher<PeripheralConnectionEvent, Never>)!
    public var state: AnyPublisher<CBManagerState, BluetoothError> {
        get { return underlyingState }
        set(value) { underlyingState = value }
    }
    public var underlyingState: (AnyPublisher<CBManagerState, BluetoothError>)!
    public var stateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError> {
        get { return underlyingStateRestoration }
        set(value) { underlyingStateRestoration = value }
    }
    public var underlyingStateRestoration: (AnyPublisher<StateRestorationEvent, BluetoothError>)!


    //MARK: - init

    public var initCentralManagerCentralManagerDependencySkipCentralManagerDelegateObservationBoolCentralManagerReceivedArguments: (centralManager: CentralManagerDependency, skipCentralManagerDelegateObservation: Bool)?
    public var initCentralManagerCentralManagerDependencySkipCentralManagerDelegateObservationBoolCentralManagerReceivedInvocations: [(centralManager: CentralManagerDependency, skipCentralManagerDelegateObservation: Bool)] = []
    public var initCentralManagerCentralManagerDependencySkipCentralManagerDelegateObservationBoolCentralManagerClosure: ((CentralManagerDependency, Bool) -> Void)?

    public required init(centralManager: CentralManagerDependency, skipCentralManagerDelegateObservation: Bool) {
        initCentralManagerCentralManagerDependencySkipCentralManagerDelegateObservationBoolCentralManagerReceivedArguments = (centralManager: centralManager, skipCentralManagerDelegateObservation: skipCentralManagerDelegateObservation)
        initCentralManagerCentralManagerDependencySkipCentralManagerDelegateObservationBoolCentralManagerReceivedInvocations.append((centralManager: centralManager, skipCentralManagerDelegateObservation: skipCentralManagerDelegateObservation))
        initCentralManagerCentralManagerDependencySkipCentralManagerDelegateObservationBoolCentralManagerClosure?(centralManager, skipCentralManagerDelegateObservation)
    }
    //MARK: - scanForPeripherals

    public var scanForPeripheralsAnyPublisherAdvertisingPeripheralBluetoothErrorCallsCount = 0
    public var scanForPeripheralsAnyPublisherAdvertisingPeripheralBluetoothErrorCalled: Bool {
        return scanForPeripheralsAnyPublisherAdvertisingPeripheralBluetoothErrorCallsCount > 0
    }
    public var scanForPeripheralsAnyPublisherAdvertisingPeripheralBluetoothErrorReturnValue: AnyPublisher<AdvertisingPeripheral, BluetoothError>!
    public var scanForPeripheralsAnyPublisherAdvertisingPeripheralBluetoothErrorClosure: (() -> AnyPublisher<AdvertisingPeripheral, BluetoothError>)?

    public func scanForPeripherals() -> AnyPublisher<AdvertisingPeripheral, BluetoothError> {
        scanForPeripheralsAnyPublisherAdvertisingPeripheralBluetoothErrorCallsCount += 1
        if let scanForPeripheralsAnyPublisherAdvertisingPeripheralBluetoothErrorClosure = scanForPeripheralsAnyPublisherAdvertisingPeripheralBluetoothErrorClosure {
            return scanForPeripheralsAnyPublisherAdvertisingPeripheralBluetoothErrorClosure()
        } else {
            return scanForPeripheralsAnyPublisherAdvertisingPeripheralBluetoothErrorReturnValue
        }
    }

    //MARK: - scanForPeripherals

    public var scanForPeripheralsWithServicesServiceUUIDsCBUUIDAnyPublisherAdvertisingPeripheralBluetoothErrorCallsCount = 0
    public var scanForPeripheralsWithServicesServiceUUIDsCBUUIDAnyPublisherAdvertisingPeripheralBluetoothErrorCalled: Bool {
        return scanForPeripheralsWithServicesServiceUUIDsCBUUIDAnyPublisherAdvertisingPeripheralBluetoothErrorCallsCount > 0
    }
    public var scanForPeripheralsWithServicesServiceUUIDsCBUUIDAnyPublisherAdvertisingPeripheralBluetoothErrorReceivedServiceUUIDs: ([CBUUID])?
    public var scanForPeripheralsWithServicesServiceUUIDsCBUUIDAnyPublisherAdvertisingPeripheralBluetoothErrorReceivedInvocations: [([CBUUID])?] = []
    public var scanForPeripheralsWithServicesServiceUUIDsCBUUIDAnyPublisherAdvertisingPeripheralBluetoothErrorReturnValue: AnyPublisher<AdvertisingPeripheral, BluetoothError>!
    public var scanForPeripheralsWithServicesServiceUUIDsCBUUIDAnyPublisherAdvertisingPeripheralBluetoothErrorClosure: (([CBUUID]?) -> AnyPublisher<AdvertisingPeripheral, BluetoothError>)?

    public func scanForPeripherals(withServices serviceUUIDs: [CBUUID]?) -> AnyPublisher<AdvertisingPeripheral, BluetoothError> {
        scanForPeripheralsWithServicesServiceUUIDsCBUUIDAnyPublisherAdvertisingPeripheralBluetoothErrorCallsCount += 1
        scanForPeripheralsWithServicesServiceUUIDsCBUUIDAnyPublisherAdvertisingPeripheralBluetoothErrorReceivedServiceUUIDs = serviceUUIDs
        scanForPeripheralsWithServicesServiceUUIDsCBUUIDAnyPublisherAdvertisingPeripheralBluetoothErrorReceivedInvocations.append(serviceUUIDs)
        if let scanForPeripheralsWithServicesServiceUUIDsCBUUIDAnyPublisherAdvertisingPeripheralBluetoothErrorClosure = scanForPeripheralsWithServicesServiceUUIDsCBUUIDAnyPublisherAdvertisingPeripheralBluetoothErrorClosure {
            return scanForPeripheralsWithServicesServiceUUIDsCBUUIDAnyPublisherAdvertisingPeripheralBluetoothErrorClosure(serviceUUIDs)
        } else {
            return scanForPeripheralsWithServicesServiceUUIDsCBUUIDAnyPublisherAdvertisingPeripheralBluetoothErrorReturnValue
        }
    }

    //MARK: - scanForPeripherals

    public var scanForPeripheralsWithServicesServiceUUIDsCBUUIDOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorCallsCount = 0
    public var scanForPeripheralsWithServicesServiceUUIDsCBUUIDOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorCalled: Bool {
        return scanForPeripheralsWithServicesServiceUUIDsCBUUIDOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorCallsCount > 0
    }
    public var scanForPeripheralsWithServicesServiceUUIDsCBUUIDOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorReceivedArguments: (serviceUUIDs: [CBUUID]?, options: [String: Any])?
    public var scanForPeripheralsWithServicesServiceUUIDsCBUUIDOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorReceivedInvocations: [(serviceUUIDs: [CBUUID]?, options: [String: Any])] = []
    public var scanForPeripheralsWithServicesServiceUUIDsCBUUIDOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorReturnValue: AnyPublisher<AdvertisingPeripheral, BluetoothError>!
    public var scanForPeripheralsWithServicesServiceUUIDsCBUUIDOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorClosure: (([CBUUID]?, [String: Any]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError>)?

    public func scanForPeripherals(withServices serviceUUIDs: [CBUUID]?, options: [String: Any]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError> {
        scanForPeripheralsWithServicesServiceUUIDsCBUUIDOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorCallsCount += 1
        scanForPeripheralsWithServicesServiceUUIDsCBUUIDOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorReceivedArguments = (serviceUUIDs: serviceUUIDs, options: options)
        scanForPeripheralsWithServicesServiceUUIDsCBUUIDOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorReceivedInvocations.append((serviceUUIDs: serviceUUIDs, options: options))
        if let scanForPeripheralsWithServicesServiceUUIDsCBUUIDOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorClosure = scanForPeripheralsWithServicesServiceUUIDsCBUUIDOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorClosure {
            return scanForPeripheralsWithServicesServiceUUIDsCBUUIDOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorClosure(serviceUUIDs, options)
        } else {
            return scanForPeripheralsWithServicesServiceUUIDsCBUUIDOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorReturnValue
        }
    }

    //MARK: - scanForPeripherals

    public var scanForPeripheralsOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorCallsCount = 0
    public var scanForPeripheralsOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorCalled: Bool {
        return scanForPeripheralsOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorCallsCount > 0
    }
    public var scanForPeripheralsOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorReceivedOptions: ([String: Any])?
    public var scanForPeripheralsOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorReceivedInvocations: [([String: Any])] = []
    public var scanForPeripheralsOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorReturnValue: AnyPublisher<AdvertisingPeripheral, BluetoothError>!
    public var scanForPeripheralsOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorClosure: (([String: Any]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError>)?

    public func scanForPeripherals(options: [String: Any]) -> AnyPublisher<AdvertisingPeripheral, BluetoothError> {
        scanForPeripheralsOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorCallsCount += 1
        scanForPeripheralsOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorReceivedOptions = options
        scanForPeripheralsOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorReceivedInvocations.append(options)
        if let scanForPeripheralsOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorClosure = scanForPeripheralsOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorClosure {
            return scanForPeripheralsOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorClosure(options)
        } else {
            return scanForPeripheralsOptionsStringAnyAnyPublisherAdvertisingPeripheralBluetoothErrorReturnValue
        }
    }

    //MARK: - retrievePeripherals

    public var retrievePeripheralsWithIdentifiersIdentifiersUUIDBluetoothPeripheralCallsCount = 0
    public var retrievePeripheralsWithIdentifiersIdentifiersUUIDBluetoothPeripheralCalled: Bool {
        return retrievePeripheralsWithIdentifiersIdentifiersUUIDBluetoothPeripheralCallsCount > 0
    }
    public var retrievePeripheralsWithIdentifiersIdentifiersUUIDBluetoothPeripheralReceivedIdentifiers: ([UUID])?
    public var retrievePeripheralsWithIdentifiersIdentifiersUUIDBluetoothPeripheralReceivedInvocations: [([UUID])] = []
    public var retrievePeripheralsWithIdentifiersIdentifiersUUIDBluetoothPeripheralReturnValue: [BluetoothPeripheral]!
    public var retrievePeripheralsWithIdentifiersIdentifiersUUIDBluetoothPeripheralClosure: (([UUID]) -> [BluetoothPeripheral])?

    public func retrievePeripherals(withIdentifiers identifiers: [UUID]) -> [BluetoothPeripheral] {
        retrievePeripheralsWithIdentifiersIdentifiersUUIDBluetoothPeripheralCallsCount += 1
        retrievePeripheralsWithIdentifiersIdentifiersUUIDBluetoothPeripheralReceivedIdentifiers = identifiers
        retrievePeripheralsWithIdentifiersIdentifiersUUIDBluetoothPeripheralReceivedInvocations.append(identifiers)
        if let retrievePeripheralsWithIdentifiersIdentifiersUUIDBluetoothPeripheralClosure = retrievePeripheralsWithIdentifiersIdentifiersUUIDBluetoothPeripheralClosure {
            return retrievePeripheralsWithIdentifiersIdentifiersUUIDBluetoothPeripheralClosure(identifiers)
        } else {
            return retrievePeripheralsWithIdentifiersIdentifiersUUIDBluetoothPeripheralReturnValue
        }
    }

    //MARK: - retrieveConnectedPeripherals

    public var retrieveConnectedPeripheralsWithServicesServiceUUIDsCBUUIDBluetoothPeripheralCallsCount = 0
    public var retrieveConnectedPeripheralsWithServicesServiceUUIDsCBUUIDBluetoothPeripheralCalled: Bool {
        return retrieveConnectedPeripheralsWithServicesServiceUUIDsCBUUIDBluetoothPeripheralCallsCount > 0
    }
    public var retrieveConnectedPeripheralsWithServicesServiceUUIDsCBUUIDBluetoothPeripheralReceivedServiceUUIDs: ([CBUUID])?
    public var retrieveConnectedPeripheralsWithServicesServiceUUIDsCBUUIDBluetoothPeripheralReceivedInvocations: [([CBUUID])] = []
    public var retrieveConnectedPeripheralsWithServicesServiceUUIDsCBUUIDBluetoothPeripheralReturnValue: [BluetoothPeripheral]!
    public var retrieveConnectedPeripheralsWithServicesServiceUUIDsCBUUIDBluetoothPeripheralClosure: (([CBUUID]) -> [BluetoothPeripheral])?

    public func retrieveConnectedPeripherals(withServices serviceUUIDs: [CBUUID]) -> [BluetoothPeripheral] {
        retrieveConnectedPeripheralsWithServicesServiceUUIDsCBUUIDBluetoothPeripheralCallsCount += 1
        retrieveConnectedPeripheralsWithServicesServiceUUIDsCBUUIDBluetoothPeripheralReceivedServiceUUIDs = serviceUUIDs
        retrieveConnectedPeripheralsWithServicesServiceUUIDsCBUUIDBluetoothPeripheralReceivedInvocations.append(serviceUUIDs)
        if let retrieveConnectedPeripheralsWithServicesServiceUUIDsCBUUIDBluetoothPeripheralClosure = retrieveConnectedPeripheralsWithServicesServiceUUIDsCBUUIDBluetoothPeripheralClosure {
            return retrieveConnectedPeripheralsWithServicesServiceUUIDsCBUUIDBluetoothPeripheralClosure(serviceUUIDs)
        } else {
            return retrieveConnectedPeripheralsWithServicesServiceUUIDsCBUUIDBluetoothPeripheralReturnValue
        }
    }

    //MARK: - connect

    public var connectPeripheralBluetoothPeripheralAnyPublisherBluetoothPeripheralBluetoothErrorCallsCount = 0
    public var connectPeripheralBluetoothPeripheralAnyPublisherBluetoothPeripheralBluetoothErrorCalled: Bool {
        return connectPeripheralBluetoothPeripheralAnyPublisherBluetoothPeripheralBluetoothErrorCallsCount > 0
    }
    public var connectPeripheralBluetoothPeripheralAnyPublisherBluetoothPeripheralBluetoothErrorReceivedPeripheral: (BluetoothPeripheral)?
    public var connectPeripheralBluetoothPeripheralAnyPublisherBluetoothPeripheralBluetoothErrorReceivedInvocations: [(BluetoothPeripheral)] = []
    public var connectPeripheralBluetoothPeripheralAnyPublisherBluetoothPeripheralBluetoothErrorReturnValue: AnyPublisher<BluetoothPeripheral, BluetoothError>!
    public var connectPeripheralBluetoothPeripheralAnyPublisherBluetoothPeripheralBluetoothErrorClosure: ((BluetoothPeripheral) -> AnyPublisher<BluetoothPeripheral, BluetoothError>)?

    public func connect(_ peripheral: BluetoothPeripheral) -> AnyPublisher<BluetoothPeripheral, BluetoothError> {
        connectPeripheralBluetoothPeripheralAnyPublisherBluetoothPeripheralBluetoothErrorCallsCount += 1
        connectPeripheralBluetoothPeripheralAnyPublisherBluetoothPeripheralBluetoothErrorReceivedPeripheral = peripheral
        connectPeripheralBluetoothPeripheralAnyPublisherBluetoothPeripheralBluetoothErrorReceivedInvocations.append(peripheral)
        if let connectPeripheralBluetoothPeripheralAnyPublisherBluetoothPeripheralBluetoothErrorClosure = connectPeripheralBluetoothPeripheralAnyPublisherBluetoothPeripheralBluetoothErrorClosure {
            return connectPeripheralBluetoothPeripheralAnyPublisherBluetoothPeripheralBluetoothErrorClosure(peripheral)
        } else {
            return connectPeripheralBluetoothPeripheralAnyPublisherBluetoothPeripheralBluetoothErrorReturnValue
        }
    }

    //MARK: - connect

    public var connectPeripheralBluetoothPeripheralOptionsStringAnyAnyPublisherBluetoothPeripheralBluetoothErrorCallsCount = 0
    public var connectPeripheralBluetoothPeripheralOptionsStringAnyAnyPublisherBluetoothPeripheralBluetoothErrorCalled: Bool {
        return connectPeripheralBluetoothPeripheralOptionsStringAnyAnyPublisherBluetoothPeripheralBluetoothErrorCallsCount > 0
    }
    public var connectPeripheralBluetoothPeripheralOptionsStringAnyAnyPublisherBluetoothPeripheralBluetoothErrorReceivedArguments: (peripheral: BluetoothPeripheral, options: [String : Any])?
    public var connectPeripheralBluetoothPeripheralOptionsStringAnyAnyPublisherBluetoothPeripheralBluetoothErrorReceivedInvocations: [(peripheral: BluetoothPeripheral, options: [String : Any])] = []
    public var connectPeripheralBluetoothPeripheralOptionsStringAnyAnyPublisherBluetoothPeripheralBluetoothErrorReturnValue: AnyPublisher<BluetoothPeripheral, BluetoothError>!
    public var connectPeripheralBluetoothPeripheralOptionsStringAnyAnyPublisherBluetoothPeripheralBluetoothErrorClosure: ((BluetoothPeripheral, [String : Any]) -> AnyPublisher<BluetoothPeripheral, BluetoothError>)?

    public func connect(_ peripheral: BluetoothPeripheral, options: [String : Any]) -> AnyPublisher<BluetoothPeripheral, BluetoothError> {
        connectPeripheralBluetoothPeripheralOptionsStringAnyAnyPublisherBluetoothPeripheralBluetoothErrorCallsCount += 1
        connectPeripheralBluetoothPeripheralOptionsStringAnyAnyPublisherBluetoothPeripheralBluetoothErrorReceivedArguments = (peripheral: peripheral, options: options)
        connectPeripheralBluetoothPeripheralOptionsStringAnyAnyPublisherBluetoothPeripheralBluetoothErrorReceivedInvocations.append((peripheral: peripheral, options: options))
        if let connectPeripheralBluetoothPeripheralOptionsStringAnyAnyPublisherBluetoothPeripheralBluetoothErrorClosure = connectPeripheralBluetoothPeripheralOptionsStringAnyAnyPublisherBluetoothPeripheralBluetoothErrorClosure {
            return connectPeripheralBluetoothPeripheralOptionsStringAnyAnyPublisherBluetoothPeripheralBluetoothErrorClosure(peripheral, options)
        } else {
            return connectPeripheralBluetoothPeripheralOptionsStringAnyAnyPublisherBluetoothPeripheralBluetoothErrorReturnValue
        }
    }

    //MARK: - peripheral

    public var peripheralForUuidUUIDBluetoothPeripheralCallsCount = 0
    public var peripheralForUuidUUIDBluetoothPeripheralCalled: Bool {
        return peripheralForUuidUUIDBluetoothPeripheralCallsCount > 0
    }
    public var peripheralForUuidUUIDBluetoothPeripheralReceivedUuid: (UUID)?
    public var peripheralForUuidUUIDBluetoothPeripheralReceivedInvocations: [(UUID)] = []
    public var peripheralForUuidUUIDBluetoothPeripheralReturnValue: BluetoothPeripheral?
    public var peripheralForUuidUUIDBluetoothPeripheralClosure: ((UUID) -> BluetoothPeripheral?)?

    public func peripheral(for uuid: UUID) -> BluetoothPeripheral? {
        peripheralForUuidUUIDBluetoothPeripheralCallsCount += 1
        peripheralForUuidUUIDBluetoothPeripheralReceivedUuid = uuid
        peripheralForUuidUUIDBluetoothPeripheralReceivedInvocations.append(uuid)
        if let peripheralForUuidUUIDBluetoothPeripheralClosure = peripheralForUuidUUIDBluetoothPeripheralClosure {
            return peripheralForUuidUUIDBluetoothPeripheralClosure(uuid)
        } else {
            return peripheralForUuidUUIDBluetoothPeripheralReturnValue
        }
    }


}
public class L2CAPChannelMock: L2CAPChannel {

    public init() {}

    public var peer: BluetoothPeer {
        get { return underlyingPeer }
        set(value) { underlyingPeer = value }
    }
    public var underlyingPeer: (BluetoothPeer)!
    public var inputStream: InputStream {
        get { return underlyingInputStream }
        set(value) { underlyingInputStream = value }
    }
    public var underlyingInputStream: (InputStream)!
    public var outputStream: OutputStream {
        get { return underlyingOutputStream }
        set(value) { underlyingOutputStream = value }
    }
    public var underlyingOutputStream: (OutputStream)!
    public var psm: CBL2CAPPSM {
        get { return underlyingPsm }
        set(value) { underlyingPsm = value }
    }
    public var underlyingPsm: (CBL2CAPPSM)!



}
public class PeripheralManagerMock: PeripheralManager {

    public init() {}

    public var isAdvertising: AnyPublisher<Bool, Never> {
        get { return underlyingIsAdvertising }
        set(value) { underlyingIsAdvertising = value }
    }
    public var underlyingIsAdvertising: (AnyPublisher<Bool, Never>)!
    public var isReadyAgainForWriteWithoutResponse: AnyPublisher<Void, Never> {
        get { return underlyingIsReadyAgainForWriteWithoutResponse }
        set(value) { underlyingIsReadyAgainForWriteWithoutResponse = value }
    }
    public var underlyingIsReadyAgainForWriteWithoutResponse: (AnyPublisher<Void, Never>)!
    public var state: AnyPublisher<CBManagerState, BluetoothError> {
        get { return underlyingState }
        set(value) { underlyingState = value }
    }
    public var underlyingState: (AnyPublisher<CBManagerState, BluetoothError>)!
    public var stateRestoration: AnyPublisher<StateRestorationEvent, BluetoothError> {
        get { return underlyingStateRestoration }
        set(value) { underlyingStateRestoration = value }
    }
    public var underlyingStateRestoration: (AnyPublisher<StateRestorationEvent, BluetoothError>)!


    //MARK: - startAdvertising

    public var startAdvertisingAnyPublisherVoidBluetoothErrorCallsCount = 0
    public var startAdvertisingAnyPublisherVoidBluetoothErrorCalled: Bool {
        return startAdvertisingAnyPublisherVoidBluetoothErrorCallsCount > 0
    }
    public var startAdvertisingAnyPublisherVoidBluetoothErrorReturnValue: AnyPublisher<Void, BluetoothError>!
    public var startAdvertisingAnyPublisherVoidBluetoothErrorClosure: (() -> AnyPublisher<Void, BluetoothError>)?

    public func startAdvertising() -> AnyPublisher<Void, BluetoothError> {
        startAdvertisingAnyPublisherVoidBluetoothErrorCallsCount += 1
        if let startAdvertisingAnyPublisherVoidBluetoothErrorClosure = startAdvertisingAnyPublisherVoidBluetoothErrorClosure {
            return startAdvertisingAnyPublisherVoidBluetoothErrorClosure()
        } else {
            return startAdvertisingAnyPublisherVoidBluetoothErrorReturnValue
        }
    }

    //MARK: - startAdvertising

    public var startAdvertisingAdvertisementDataStringAnyAnyPublisherVoidBluetoothErrorCallsCount = 0
    public var startAdvertisingAdvertisementDataStringAnyAnyPublisherVoidBluetoothErrorCalled: Bool {
        return startAdvertisingAdvertisementDataStringAnyAnyPublisherVoidBluetoothErrorCallsCount > 0
    }
    public var startAdvertisingAdvertisementDataStringAnyAnyPublisherVoidBluetoothErrorReceivedAdvertisementData: ([String: Any])?
    public var startAdvertisingAdvertisementDataStringAnyAnyPublisherVoidBluetoothErrorReceivedInvocations: [([String: Any])] = []
    public var startAdvertisingAdvertisementDataStringAnyAnyPublisherVoidBluetoothErrorReturnValue: AnyPublisher<Void, BluetoothError>!
    public var startAdvertisingAdvertisementDataStringAnyAnyPublisherVoidBluetoothErrorClosure: (([String: Any]) -> AnyPublisher<Void, BluetoothError>)?

    public func startAdvertising(advertisementData: [String: Any]) -> AnyPublisher<Void, BluetoothError> {
        startAdvertisingAdvertisementDataStringAnyAnyPublisherVoidBluetoothErrorCallsCount += 1
        startAdvertisingAdvertisementDataStringAnyAnyPublisherVoidBluetoothErrorReceivedAdvertisementData = advertisementData
        startAdvertisingAdvertisementDataStringAnyAnyPublisherVoidBluetoothErrorReceivedInvocations.append(advertisementData)
        if let startAdvertisingAdvertisementDataStringAnyAnyPublisherVoidBluetoothErrorClosure = startAdvertisingAdvertisementDataStringAnyAnyPublisherVoidBluetoothErrorClosure {
            return startAdvertisingAdvertisementDataStringAnyAnyPublisherVoidBluetoothErrorClosure(advertisementData)
        } else {
            return startAdvertisingAdvertisementDataStringAnyAnyPublisherVoidBluetoothErrorReturnValue
        }
    }

    //MARK: - setDesiredConnectionLatency

    public var setDesiredConnectionLatencyLatencyCBPeripheralManagerConnectionLatencyForCentralBluetoothCentralResultVoidBluetoothErrorCallsCount = 0
    public var setDesiredConnectionLatencyLatencyCBPeripheralManagerConnectionLatencyForCentralBluetoothCentralResultVoidBluetoothErrorCalled: Bool {
        return setDesiredConnectionLatencyLatencyCBPeripheralManagerConnectionLatencyForCentralBluetoothCentralResultVoidBluetoothErrorCallsCount > 0
    }
    public var setDesiredConnectionLatencyLatencyCBPeripheralManagerConnectionLatencyForCentralBluetoothCentralResultVoidBluetoothErrorReceivedArguments: (latency: CBPeripheralManagerConnectionLatency, central: BluetoothCentral)?
    public var setDesiredConnectionLatencyLatencyCBPeripheralManagerConnectionLatencyForCentralBluetoothCentralResultVoidBluetoothErrorReceivedInvocations: [(latency: CBPeripheralManagerConnectionLatency, central: BluetoothCentral)] = []
    public var setDesiredConnectionLatencyLatencyCBPeripheralManagerConnectionLatencyForCentralBluetoothCentralResultVoidBluetoothErrorReturnValue: Result<Void, BluetoothError>!
    public var setDesiredConnectionLatencyLatencyCBPeripheralManagerConnectionLatencyForCentralBluetoothCentralResultVoidBluetoothErrorClosure: ((CBPeripheralManagerConnectionLatency, BluetoothCentral) -> Result<Void, BluetoothError>)?

    public func setDesiredConnectionLatency(_ latency: CBPeripheralManagerConnectionLatency, for central: BluetoothCentral) -> Result<Void, BluetoothError> {
        setDesiredConnectionLatencyLatencyCBPeripheralManagerConnectionLatencyForCentralBluetoothCentralResultVoidBluetoothErrorCallsCount += 1
        setDesiredConnectionLatencyLatencyCBPeripheralManagerConnectionLatencyForCentralBluetoothCentralResultVoidBluetoothErrorReceivedArguments = (latency: latency, central: central)
        setDesiredConnectionLatencyLatencyCBPeripheralManagerConnectionLatencyForCentralBluetoothCentralResultVoidBluetoothErrorReceivedInvocations.append((latency: latency, central: central))
        if let setDesiredConnectionLatencyLatencyCBPeripheralManagerConnectionLatencyForCentralBluetoothCentralResultVoidBluetoothErrorClosure = setDesiredConnectionLatencyLatencyCBPeripheralManagerConnectionLatencyForCentralBluetoothCentralResultVoidBluetoothErrorClosure {
            return setDesiredConnectionLatencyLatencyCBPeripheralManagerConnectionLatencyForCentralBluetoothCentralResultVoidBluetoothErrorClosure(latency, central)
        } else {
            return setDesiredConnectionLatencyLatencyCBPeripheralManagerConnectionLatencyForCentralBluetoothCentralResultVoidBluetoothErrorReturnValue
        }
    }

    //MARK: - add

    public var addServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorCallsCount = 0
    public var addServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorCalled: Bool {
        return addServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorCallsCount > 0
    }
    public var addServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorReceivedService: (BluetoothService)?
    public var addServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorReceivedInvocations: [(BluetoothService)] = []
    public var addServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorReturnValue: AnyPublisher<BluetoothService, BluetoothError>!
    public var addServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorClosure: ((BluetoothService) -> AnyPublisher<BluetoothService, BluetoothError>)?

    public func add(_ service: BluetoothService) -> AnyPublisher<BluetoothService, BluetoothError> {
        addServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorCallsCount += 1
        addServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorReceivedService = service
        addServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorReceivedInvocations.append(service)
        if let addServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorClosure = addServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorClosure {
            return addServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorClosure(service)
        } else {
            return addServiceBluetoothServiceAnyPublisherBluetoothServiceBluetoothErrorReturnValue
        }
    }

    //MARK: - remove

    public var removeServiceBluetoothServiceResultBluetoothServiceBluetoothErrorCallsCount = 0
    public var removeServiceBluetoothServiceResultBluetoothServiceBluetoothErrorCalled: Bool {
        return removeServiceBluetoothServiceResultBluetoothServiceBluetoothErrorCallsCount > 0
    }
    public var removeServiceBluetoothServiceResultBluetoothServiceBluetoothErrorReceivedService: (BluetoothService)?
    public var removeServiceBluetoothServiceResultBluetoothServiceBluetoothErrorReceivedInvocations: [(BluetoothService)] = []
    public var removeServiceBluetoothServiceResultBluetoothServiceBluetoothErrorReturnValue: Result<BluetoothService, BluetoothError>!
    public var removeServiceBluetoothServiceResultBluetoothServiceBluetoothErrorClosure: ((BluetoothService) -> Result<BluetoothService, BluetoothError>)?

    public func remove(_ service: BluetoothService) -> Result<BluetoothService, BluetoothError> {
        removeServiceBluetoothServiceResultBluetoothServiceBluetoothErrorCallsCount += 1
        removeServiceBluetoothServiceResultBluetoothServiceBluetoothErrorReceivedService = service
        removeServiceBluetoothServiceResultBluetoothServiceBluetoothErrorReceivedInvocations.append(service)
        if let removeServiceBluetoothServiceResultBluetoothServiceBluetoothErrorClosure = removeServiceBluetoothServiceResultBluetoothServiceBluetoothErrorClosure {
            return removeServiceBluetoothServiceResultBluetoothServiceBluetoothErrorClosure(service)
        } else {
            return removeServiceBluetoothServiceResultBluetoothServiceBluetoothErrorReturnValue
        }
    }

    //MARK: - removeAllServices

    public var removeAllServicesVoidCallsCount = 0
    public var removeAllServicesVoidCalled: Bool {
        return removeAllServicesVoidCallsCount > 0
    }
    public var removeAllServicesVoidClosure: (() -> Void)?

    public func removeAllServices() {
        removeAllServicesVoidCallsCount += 1
        removeAllServicesVoidClosure?()
    }

    //MARK: - respond

    public var respondToRequestATTRequestWithResultResultCBATTErrorCodeResultVoidBluetoothErrorCallsCount = 0
    public var respondToRequestATTRequestWithResultResultCBATTErrorCodeResultVoidBluetoothErrorCalled: Bool {
        return respondToRequestATTRequestWithResultResultCBATTErrorCodeResultVoidBluetoothErrorCallsCount > 0
    }
    public var respondToRequestATTRequestWithResultResultCBATTErrorCodeResultVoidBluetoothErrorReceivedArguments: (request: ATTRequest, result: CBATTError.Code)?
    public var respondToRequestATTRequestWithResultResultCBATTErrorCodeResultVoidBluetoothErrorReceivedInvocations: [(request: ATTRequest, result: CBATTError.Code)] = []
    public var respondToRequestATTRequestWithResultResultCBATTErrorCodeResultVoidBluetoothErrorReturnValue: Result<Void, BluetoothError>!
    public var respondToRequestATTRequestWithResultResultCBATTErrorCodeResultVoidBluetoothErrorClosure: ((ATTRequest, CBATTError.Code) -> Result<Void, BluetoothError>)?

    public func respond(to request: ATTRequest, withResult result: CBATTError.Code) -> Result<Void, BluetoothError> {
        respondToRequestATTRequestWithResultResultCBATTErrorCodeResultVoidBluetoothErrorCallsCount += 1
        respondToRequestATTRequestWithResultResultCBATTErrorCodeResultVoidBluetoothErrorReceivedArguments = (request: request, result: result)
        respondToRequestATTRequestWithResultResultCBATTErrorCodeResultVoidBluetoothErrorReceivedInvocations.append((request: request, result: result))
        if let respondToRequestATTRequestWithResultResultCBATTErrorCodeResultVoidBluetoothErrorClosure = respondToRequestATTRequestWithResultResultCBATTErrorCodeResultVoidBluetoothErrorClosure {
            return respondToRequestATTRequestWithResultResultCBATTErrorCodeResultVoidBluetoothErrorClosure(request, result)
        } else {
            return respondToRequestATTRequestWithResultResultCBATTErrorCodeResultVoidBluetoothErrorReturnValue
        }
    }

    //MARK: - updateValue

    public var updateValueValueDataForCharacteristicBluetoothCharacteristicOnSubscribedCentralsCentralsBluetoothCentralResultBoolBluetoothErrorCallsCount = 0
    public var updateValueValueDataForCharacteristicBluetoothCharacteristicOnSubscribedCentralsCentralsBluetoothCentralResultBoolBluetoothErrorCalled: Bool {
        return updateValueValueDataForCharacteristicBluetoothCharacteristicOnSubscribedCentralsCentralsBluetoothCentralResultBoolBluetoothErrorCallsCount > 0
    }
    public var updateValueValueDataForCharacteristicBluetoothCharacteristicOnSubscribedCentralsCentralsBluetoothCentralResultBoolBluetoothErrorReceivedArguments: (value: Data, characteristic: BluetoothCharacteristic, centrals: [BluetoothCentral]?)?
    public var updateValueValueDataForCharacteristicBluetoothCharacteristicOnSubscribedCentralsCentralsBluetoothCentralResultBoolBluetoothErrorReceivedInvocations: [(value: Data, characteristic: BluetoothCharacteristic, centrals: [BluetoothCentral]?)] = []
    public var updateValueValueDataForCharacteristicBluetoothCharacteristicOnSubscribedCentralsCentralsBluetoothCentralResultBoolBluetoothErrorReturnValue: Result<Bool, BluetoothError>!
    public var updateValueValueDataForCharacteristicBluetoothCharacteristicOnSubscribedCentralsCentralsBluetoothCentralResultBoolBluetoothErrorClosure: ((Data, BluetoothCharacteristic, [BluetoothCentral]?) -> Result<Bool, BluetoothError>)?

    public func updateValue(_ value: Data, for characteristic: BluetoothCharacteristic, onSubscribedCentrals centrals: [BluetoothCentral]?) -> Result<Bool, BluetoothError> {
        updateValueValueDataForCharacteristicBluetoothCharacteristicOnSubscribedCentralsCentralsBluetoothCentralResultBoolBluetoothErrorCallsCount += 1
        updateValueValueDataForCharacteristicBluetoothCharacteristicOnSubscribedCentralsCentralsBluetoothCentralResultBoolBluetoothErrorReceivedArguments = (value: value, characteristic: characteristic, centrals: centrals)
        updateValueValueDataForCharacteristicBluetoothCharacteristicOnSubscribedCentralsCentralsBluetoothCentralResultBoolBluetoothErrorReceivedInvocations.append((value: value, characteristic: characteristic, centrals: centrals))
        if let updateValueValueDataForCharacteristicBluetoothCharacteristicOnSubscribedCentralsCentralsBluetoothCentralResultBoolBluetoothErrorClosure = updateValueValueDataForCharacteristicBluetoothCharacteristicOnSubscribedCentralsCentralsBluetoothCentralResultBoolBluetoothErrorClosure {
            return updateValueValueDataForCharacteristicBluetoothCharacteristicOnSubscribedCentralsCentralsBluetoothCentralResultBoolBluetoothErrorClosure(value, characteristic, centrals)
        } else {
            return updateValueValueDataForCharacteristicBluetoothCharacteristicOnSubscribedCentralsCentralsBluetoothCentralResultBoolBluetoothErrorReturnValue
        }
    }

    //MARK: - publishL2CAPChannel

    public var publishL2CAPChannelWithEncryptionEncryptionRequiredBoolAnyPublisherCBL2CAPPSMBluetoothErrorCallsCount = 0
    public var publishL2CAPChannelWithEncryptionEncryptionRequiredBoolAnyPublisherCBL2CAPPSMBluetoothErrorCalled: Bool {
        return publishL2CAPChannelWithEncryptionEncryptionRequiredBoolAnyPublisherCBL2CAPPSMBluetoothErrorCallsCount > 0
    }
    public var publishL2CAPChannelWithEncryptionEncryptionRequiredBoolAnyPublisherCBL2CAPPSMBluetoothErrorReceivedEncryptionRequired: (Bool)?
    public var publishL2CAPChannelWithEncryptionEncryptionRequiredBoolAnyPublisherCBL2CAPPSMBluetoothErrorReceivedInvocations: [(Bool)] = []
    public var publishL2CAPChannelWithEncryptionEncryptionRequiredBoolAnyPublisherCBL2CAPPSMBluetoothErrorReturnValue: AnyPublisher<CBL2CAPPSM, BluetoothError>!
    public var publishL2CAPChannelWithEncryptionEncryptionRequiredBoolAnyPublisherCBL2CAPPSMBluetoothErrorClosure: ((Bool) -> AnyPublisher<CBL2CAPPSM, BluetoothError>)?

    public func publishL2CAPChannel(withEncryption encryptionRequired: Bool) -> AnyPublisher<CBL2CAPPSM, BluetoothError> {
        publishL2CAPChannelWithEncryptionEncryptionRequiredBoolAnyPublisherCBL2CAPPSMBluetoothErrorCallsCount += 1
        publishL2CAPChannelWithEncryptionEncryptionRequiredBoolAnyPublisherCBL2CAPPSMBluetoothErrorReceivedEncryptionRequired = encryptionRequired
        publishL2CAPChannelWithEncryptionEncryptionRequiredBoolAnyPublisherCBL2CAPPSMBluetoothErrorReceivedInvocations.append(encryptionRequired)
        if let publishL2CAPChannelWithEncryptionEncryptionRequiredBoolAnyPublisherCBL2CAPPSMBluetoothErrorClosure = publishL2CAPChannelWithEncryptionEncryptionRequiredBoolAnyPublisherCBL2CAPPSMBluetoothErrorClosure {
            return publishL2CAPChannelWithEncryptionEncryptionRequiredBoolAnyPublisherCBL2CAPPSMBluetoothErrorClosure(encryptionRequired)
        } else {
            return publishL2CAPChannelWithEncryptionEncryptionRequiredBoolAnyPublisherCBL2CAPPSMBluetoothErrorReturnValue
        }
    }

    //MARK: - unpublishL2CAPChannel

    public var unpublishL2CAPChannelPSMCBL2CAPPSMAnyPublisherCBL2CAPPSMBluetoothErrorCallsCount = 0
    public var unpublishL2CAPChannelPSMCBL2CAPPSMAnyPublisherCBL2CAPPSMBluetoothErrorCalled: Bool {
        return unpublishL2CAPChannelPSMCBL2CAPPSMAnyPublisherCBL2CAPPSMBluetoothErrorCallsCount > 0
    }
    public var unpublishL2CAPChannelPSMCBL2CAPPSMAnyPublisherCBL2CAPPSMBluetoothErrorReceivedPSM: (CBL2CAPPSM)?
    public var unpublishL2CAPChannelPSMCBL2CAPPSMAnyPublisherCBL2CAPPSMBluetoothErrorReceivedInvocations: [(CBL2CAPPSM)] = []
    public var unpublishL2CAPChannelPSMCBL2CAPPSMAnyPublisherCBL2CAPPSMBluetoothErrorReturnValue: AnyPublisher<CBL2CAPPSM, BluetoothError>!
    public var unpublishL2CAPChannelPSMCBL2CAPPSMAnyPublisherCBL2CAPPSMBluetoothErrorClosure: ((CBL2CAPPSM) -> AnyPublisher<CBL2CAPPSM, BluetoothError>)?

    public func unpublishL2CAPChannel(_ PSM: CBL2CAPPSM) -> AnyPublisher<CBL2CAPPSM, BluetoothError> {
        unpublishL2CAPChannelPSMCBL2CAPPSMAnyPublisherCBL2CAPPSMBluetoothErrorCallsCount += 1
        unpublishL2CAPChannelPSMCBL2CAPPSMAnyPublisherCBL2CAPPSMBluetoothErrorReceivedPSM = PSM
        unpublishL2CAPChannelPSMCBL2CAPPSMAnyPublisherCBL2CAPPSMBluetoothErrorReceivedInvocations.append(PSM)
        if let unpublishL2CAPChannelPSMCBL2CAPPSMAnyPublisherCBL2CAPPSMBluetoothErrorClosure = unpublishL2CAPChannelPSMCBL2CAPPSMAnyPublisherCBL2CAPPSMBluetoothErrorClosure {
            return unpublishL2CAPChannelPSMCBL2CAPPSMAnyPublisherCBL2CAPPSMBluetoothErrorClosure(PSM)
        } else {
            return unpublishL2CAPChannelPSMCBL2CAPPSMAnyPublisherCBL2CAPPSMBluetoothErrorReturnValue
        }
    }


}

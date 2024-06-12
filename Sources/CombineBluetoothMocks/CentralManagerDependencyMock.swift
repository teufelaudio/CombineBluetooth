import Combine
import CombineBluetooth
import CoreBluetooth

// This mock is created because sourcery is not yet able to resolve where clauses in generic
// protocols correctly, which is hard to do. As it is not worth the effort to adjust the template
// accordingly and as we would loose the ability to just copy the newest AutoMockable.stencil template
// I'd honestly just let sourcery create the base of this mock, copy it over here and adjust it 
// as expected. This means letting it confirm to NSObject as well as adding the overrride initializer.

public class CentralManagerDependencyMock: NSObject, CentralManagerDependency {
    public override init() {}

    public var state: CBManagerState {
        get { return underlyingState }
        set(value) { underlyingState = value }
    }
    public var underlyingState: (CBManagerState)!
    public var delegate: CBCentralManagerDelegate?
    public var isScanning: Bool {
        get { return underlyingIsScanning }
        set(value) { underlyingIsScanning = value }
    }
    public var underlyingIsScanning: (Bool)!


    //MARK: - stopScan

    public var stopScanVoidCallsCount = 0
    public var stopScanVoidCalled: Bool {
        return stopScanVoidCallsCount > 0
    }
    public var stopScanVoidClosure: (() -> Void)?

    public func stopScan() {
        stopScanVoidCallsCount += 1
        stopScanVoidClosure?()
    }

    //MARK: - scanForPeripherals

    public var scanForPeripheralsWithServicesCBUUIDOptionsStringAnyVoidCallsCount = 0
    public var scanForPeripheralsWithServicesCBUUIDOptionsStringAnyVoidCalled: Bool {
        return scanForPeripheralsWithServicesCBUUIDOptionsStringAnyVoidCallsCount > 0
    }
    public var scanForPeripheralsWithServicesCBUUIDOptionsStringAnyVoidReceivedArguments: (withServices: [CBUUID]?, options: [String : Any]?)?
    public var scanForPeripheralsWithServicesCBUUIDOptionsStringAnyVoidReceivedInvocations: [(withServices: [CBUUID]?, options: [String : Any]?)] = []
    public var scanForPeripheralsWithServicesCBUUIDOptionsStringAnyVoidClosure: (([CBUUID]?, [String : Any]?) -> Void)?

    public func scanForPeripherals(withServices: [CBUUID]?, options: [String : Any]?) {
        scanForPeripheralsWithServicesCBUUIDOptionsStringAnyVoidCallsCount += 1
        scanForPeripheralsWithServicesCBUUIDOptionsStringAnyVoidReceivedArguments = (withServices: withServices, options: options)
        scanForPeripheralsWithServicesCBUUIDOptionsStringAnyVoidReceivedInvocations.append((withServices: withServices, options: options))
        scanForPeripheralsWithServicesCBUUIDOptionsStringAnyVoidClosure?(withServices, options)
    }

    //MARK: - connect

    public var connectPeripheralCBPeripheralOptionsStringAnyVoidCallsCount = 0
    public var connectPeripheralCBPeripheralOptionsStringAnyVoidCalled: Bool {
        return connectPeripheralCBPeripheralOptionsStringAnyVoidCallsCount > 0
    }
    public var connectPeripheralCBPeripheralOptionsStringAnyVoidReceivedArguments: (peripheral: CBPeripheral, options: [String: Any]?)?
    public var connectPeripheralCBPeripheralOptionsStringAnyVoidReceivedInvocations: [(peripheral: CBPeripheral, options: [String: Any]?)] = []
    public var connectPeripheralCBPeripheralOptionsStringAnyVoidClosure: ((CBPeripheral, [String: Any]?) -> Void)?

    @objc(connectPeripheral:options:)
    public func connect(_ peripheral: CBPeripheral, options: [String: Any]?) {
        connectPeripheralCBPeripheralOptionsStringAnyVoidCallsCount += 1
        connectPeripheralCBPeripheralOptionsStringAnyVoidReceivedArguments = (peripheral: peripheral, options: options)
        connectPeripheralCBPeripheralOptionsStringAnyVoidReceivedInvocations.append((peripheral: peripheral, options: options))
        connectPeripheralCBPeripheralOptionsStringAnyVoidClosure?(peripheral, options)
    }

    //MARK: - cancelPeripheralConnection

    public var cancelPeripheralConnectionPeripheralCBPeripheralVoidCallsCount = 0
    public var cancelPeripheralConnectionPeripheralCBPeripheralVoidCalled: Bool {
        return cancelPeripheralConnectionPeripheralCBPeripheralVoidCallsCount > 0
    }
    public var cancelPeripheralConnectionPeripheralCBPeripheralVoidReceivedPeripheral: (CBPeripheral)?
    public var cancelPeripheralConnectionPeripheralCBPeripheralVoidReceivedInvocations: [(CBPeripheral)] = []
    public var cancelPeripheralConnectionPeripheralCBPeripheralVoidClosure: ((CBPeripheral) -> Void)?

    public func cancelPeripheralConnection(_ peripheral: CBPeripheral) {
        cancelPeripheralConnectionPeripheralCBPeripheralVoidCallsCount += 1
        cancelPeripheralConnectionPeripheralCBPeripheralVoidReceivedPeripheral = peripheral
        cancelPeripheralConnectionPeripheralCBPeripheralVoidReceivedInvocations.append(peripheral)
        cancelPeripheralConnectionPeripheralCBPeripheralVoidClosure?(peripheral)
    }

    //MARK: - retrievePeripherals

    public var retrievePeripheralsWithIdentifiersUUIDCBPeripheralCallsCount = 0
    public var retrievePeripheralsWithIdentifiersUUIDCBPeripheralCalled: Bool {
        return retrievePeripheralsWithIdentifiersUUIDCBPeripheralCallsCount > 0
    }
    public var retrievePeripheralsWithIdentifiersUUIDCBPeripheralReceivedWithIdentifiers: ([UUID])?
    public var retrievePeripheralsWithIdentifiersUUIDCBPeripheralReceivedInvocations: [([UUID])] = []
    public var retrievePeripheralsWithIdentifiersUUIDCBPeripheralReturnValue: [CBPeripheral]!
    public var retrievePeripheralsWithIdentifiersUUIDCBPeripheralClosure: (([UUID]) -> [CBPeripheral])?

    public func retrievePeripherals(withIdentifiers: [UUID]) -> [CBPeripheral] {
        retrievePeripheralsWithIdentifiersUUIDCBPeripheralCallsCount += 1
        retrievePeripheralsWithIdentifiersUUIDCBPeripheralReceivedWithIdentifiers = withIdentifiers
        retrievePeripheralsWithIdentifiersUUIDCBPeripheralReceivedInvocations.append(withIdentifiers)
        if let retrievePeripheralsWithIdentifiersUUIDCBPeripheralClosure = retrievePeripheralsWithIdentifiersUUIDCBPeripheralClosure {
            return retrievePeripheralsWithIdentifiersUUIDCBPeripheralClosure(withIdentifiers)
        } else {
            return retrievePeripheralsWithIdentifiersUUIDCBPeripheralReturnValue
        }
    }

    //MARK: - retrieveConnectedPeripherals

    public var retrieveConnectedPeripheralsWithServicesCBUUIDCBPeripheralCallsCount = 0
    public var retrieveConnectedPeripheralsWithServicesCBUUIDCBPeripheralCalled: Bool {
        return retrieveConnectedPeripheralsWithServicesCBUUIDCBPeripheralCallsCount > 0
    }
    public var retrieveConnectedPeripheralsWithServicesCBUUIDCBPeripheralReceivedWithServices: ([CBUUID])?
    public var retrieveConnectedPeripheralsWithServicesCBUUIDCBPeripheralReceivedInvocations: [([CBUUID])] = []
    public var retrieveConnectedPeripheralsWithServicesCBUUIDCBPeripheralReturnValue: [CBPeripheral]!
    public var retrieveConnectedPeripheralsWithServicesCBUUIDCBPeripheralClosure: (([CBUUID]) -> [CBPeripheral])?

    public func retrieveConnectedPeripherals(withServices: [CBUUID]) -> [CBPeripheral] {
        retrieveConnectedPeripheralsWithServicesCBUUIDCBPeripheralCallsCount += 1
        retrieveConnectedPeripheralsWithServicesCBUUIDCBPeripheralReceivedWithServices = withServices
        retrieveConnectedPeripheralsWithServicesCBUUIDCBPeripheralReceivedInvocations.append(withServices)
        if let retrieveConnectedPeripheralsWithServicesCBUUIDCBPeripheralClosure = retrieveConnectedPeripheralsWithServicesCBUUIDCBPeripheralClosure {
            return retrieveConnectedPeripheralsWithServicesCBUUIDCBPeripheralClosure(withServices)
        } else {
            return retrieveConnectedPeripheralsWithServicesCBUUIDCBPeripheralReturnValue
        }
    }


}

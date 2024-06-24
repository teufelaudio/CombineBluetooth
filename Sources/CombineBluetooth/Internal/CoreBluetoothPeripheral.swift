import Combine
import CoreBluetooth

class CoreBluetoothPeripheral: NSObject, Identifiable {
    var id: UUID { peripheral.id }
    let peripheral: CBPeripheral
    private let didReadRSSI = PassthroughSubject<Result<NSNumber, Error>, Never>()
    private let didDiscoverServices = PassthroughSubject<Result<[CBService], Error>, Never>()
    private let didDiscoverIncludedServices = PassthroughSubject<Result<(parent: CBService, included: [CBService]), Error>, Never>()
    private let didDiscoverCharacteristics = PassthroughSubject<Result<(service: CBService, characteristics: [CBCharacteristic]), Error>, Never>()
    private let readValueForCharacteristic = PassthroughSubject<Result<CBCharacteristic, Error>, Never>()
    private let didWriteValueForCharacteristic = PassthroughSubject<Result<CBCharacteristic, Error>, Never>()
    private let didUpdateNotificationStateForCharacteristic = PassthroughSubject<Result<CBCharacteristic, Error>, Never>()
    private let didOpenChannel = PassthroughSubject<Result<L2CAPChannel, Error>, Never>()
    private let didDiscoverDescriptors = PassthroughSubject<Result<(characteristic: CBCharacteristic, descriptors: [CBDescriptor]), Error>, Never>()
    private let readValueForDescriptor = PassthroughSubject<Result<CBDescriptor, Error>, Never>()
    private let didWriteValueForDescriptor = PassthroughSubject<Result<CBDescriptor, Error>, Never>()
    private let becameReadyForWriteWithoutResponse = PassthroughSubject<Void, Never>()

    static func wrapping(peripheral: CBPeripheral) -> CoreBluetoothPeripheral {
        CoreBluetoothPeripheral(peripheral: peripheral)
    }

    weak var proxyDelegate: CBPeripheralDelegate?
    
    private init(peripheral: CBPeripheral) {
        self.peripheral = peripheral
        super.init()
        self.peripheral.delegate = self
    }
}

extension CoreBluetoothPeripheral: CBPeripheralDelegate {
    func peripheralDidUpdateName(_ peripheral: CBPeripheral) { 
        proxyDelegate?.peripheralDidUpdateName?(peripheral)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        didReadRSSI.send(error.map(Result.failure) ?? .success(RSSI))
        proxyDelegate?.peripheral?(peripheral, didReadRSSI: RSSI, error: error)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        didDiscoverServices.send(error.map(Result.failure) ?? .success(peripheral.services ?? []))
        proxyDelegate?.peripheral?(peripheral, didDiscoverServices: error)
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverIncludedServicesFor service: CBService, error: Error?) {
        didDiscoverIncludedServices.send(error.map(Result.failure) ?? .success((parent: service, included: service.includedServices ?? [])))
        proxyDelegate?.peripheral?(peripheral, didDiscoverIncludedServicesFor: service, error: error)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        didDiscoverCharacteristics.send(error.map(Result.failure) ?? .success((service: service, characteristics: service.characteristics ?? [])))
        proxyDelegate?.peripheral?(peripheral, didDiscoverCharacteristicsFor: service, error: error)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        readValueForCharacteristic.send(error.map(Result.failure) ?? .success(characteristic))
        proxyDelegate?.peripheral?(peripheral, didUpdateValueFor: characteristic, error: error)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        didWriteValueForCharacteristic.send(error.map(Result.failure) ?? .success(characteristic))
        proxyDelegate?.peripheral?(peripheral, didWriteValueFor: characteristic, error: error)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        didUpdateNotificationStateForCharacteristic.send(error.map(Result.failure) ?? .success(characteristic))
        proxyDelegate?.peripheral?(peripheral, didUpdateNotificationStateFor: characteristic, error: error)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        readValueForDescriptor.send(error.map(Result.failure) ?? .success(descriptor))
        proxyDelegate?.peripheral?(peripheral, didUpdateValueFor: descriptor, error: error)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        didDiscoverDescriptors.send(error.map(Result.failure) ?? .success((characteristic: characteristic, descriptors: characteristic.descriptors ?? [])))
        proxyDelegate?.peripheral?(peripheral, didDiscoverDescriptorsFor: characteristic, error: error)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
        didWriteValueForDescriptor.send(error.map(Result.failure) ?? .success(descriptor))
        proxyDelegate?.peripheral?(peripheral, didWriteValueFor: descriptor, error: error)
    }
    
    func peripheralIsReady(toSendWriteWithoutResponse peripheral: CBPeripheral) {
        becameReadyForWriteWithoutResponse.send(())
        proxyDelegate?.peripheralIsReady?(toSendWriteWithoutResponse: peripheral)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didOpen channel: CBL2CAPChannel?, error: Error?) {
        didOpenChannel.send(
            error.map(Result.failure)
                ?? channel.map(CoreBluetoothL2CAPChannel.init).map(Result.success)
                ?? Result.failure(NSError(
                    domain: "peripheral(_ peripheral: CBPeripheral, didOpen channel: CBL2CAPChannel?, error: Error?) with both nil",
                    code: -1,
                    userInfo: nil
                ))
        )
        proxyDelegate?.peripheral?(peripheral, didOpen: channel, error: error)
    }
}

extension CoreBluetoothPeripheral: BluetoothPeripheral {
    var name: String? { peripheral.name }
    var state: CBPeripheralState { peripheral.state }
    var services: [BluetoothService]? { peripheral.services?.map(CoreBluetoothService.init) }
    var canSendWriteWithoutResponse: Bool { peripheral.canSendWriteWithoutResponse }
    var isReadyAgainForWriteWithoutResponse: AnyPublisher<Void, Never> {
        return becameReadyForWriteWithoutResponse.eraseToAnyPublisher()
    }

    func readRSSI() -> AnyPublisher<NSNumber, BluetoothError> {
        let peripheral = self.peripheral
        return didReadRSSI
            .tryMap { try $0.get() }
            .mapError {
                BluetoothError.onReadRSSI(
                    peripheral: CoreBluetoothPeripheral(peripheral: peripheral),
                    details: $0
                )
            }
            .handleEvents(receiveSubscription: { _ in
                peripheral.readRSSI()
            })
            .eraseToAnyPublisher()
    }

    func discoverServices(_ serviceUUIDs: [CBUUID]?) -> AnyPublisher<BluetoothService, BluetoothError> {
        let peripheral = self.peripheral
        return didDiscoverServices
            .tryMap { try $0.get() }
            .flatMap { services in
                services
                    .filter { serviceUUIDs?.contains($0.id) ?? true }
                    .map(CoreBluetoothService.init)
                    .publisher
                    .mapError(absurd)
            }
            .mapError {
                BluetoothError.onDiscoverServices(
                    peripheral: CoreBluetoothPeripheral(peripheral: peripheral),
                    details: $0
                )
            }
            .handleEvents(receiveSubscription: { _ in
                peripheral.discoverServices(serviceUUIDs)
            })
            .eraseToAnyPublisher()
    }

    func discoverIncludedServices(_ includedServiceUUIDs: [CBUUID]?, for service: BluetoothService) -> AnyPublisher<BluetoothService, BluetoothError> {
        guard let coreBluetoothService = service as? CoreBluetoothService else { return Fail(error: .unknownWrapperType).eraseToAnyPublisher() }
        let peripheral = self.peripheral
        return didDiscoverIncludedServices
            .tryMap { try $0.get() }
            .filter { $0.parent.id == coreBluetoothService.service.id }
            .flatMap { service in
                service
                    .included
                    .filter { includedServiceUUIDs?.contains($0.id) ?? true }
                    .map(CoreBluetoothService.init)
                    .publisher
                    .mapError(absurd)
            }
            .mapError {
                BluetoothError.onDiscoverIncludedServices(
                    service: service,
                    details: $0
                )
            }
            .handleEvents(receiveSubscription: { _ in
                peripheral.discoverIncludedServices(includedServiceUUIDs, for: coreBluetoothService.service)
            })
            .eraseToAnyPublisher()
    }

    func discoverCharacteristics(_ characteristicUUIDs: [CBUUID]?, for service: BluetoothService) -> AnyPublisher<BluetoothCharacteristic, BluetoothError> {
        guard let coreBluetoothService = service as? CoreBluetoothService else { return Fail(error: .unknownWrapperType).eraseToAnyPublisher() }
        let peripheral = self.peripheral
        return didDiscoverCharacteristics
            .tryMap { try $0.get() }
            .filter { $0.service.id == coreBluetoothService.service.id }
            .flatMap { service in
                service
                    .characteristics
                    .filter { characteristicUUIDs?.contains($0.id) ?? true }
                    .map(CoreBluetoothCharacteristic.init)
                    .publisher
                    .mapError(absurd)
            }
            .mapError {
                BluetoothError.onDiscoverCharacteristics(
                    service: CoreBluetoothService(service: coreBluetoothService.service),
                    details: $0
                )
            }
            .handleEvents(receiveSubscription: { _ in
                peripheral.discoverCharacteristics(characteristicUUIDs, for: coreBluetoothService.service)
            })
            .eraseToAnyPublisher()
    }

    func readCharacteristicValue(_ characteristic: BluetoothCharacteristic) -> AnyPublisher<BluetoothCharacteristic, BluetoothError> {
        guard let coreBluetoothCharacteristic = characteristic as? CoreBluetoothCharacteristic
        else { return Fail(error: .unknownWrapperType).eraseToAnyPublisher() }
        let peripheral = self.peripheral
        return readValueForCharacteristic
            .tryMap { try $0.get() }
            .filter { $0.id == coreBluetoothCharacteristic.characteristic.id }
            .map(CoreBluetoothCharacteristic.init)
            .mapError {
                BluetoothError.onReadValueForCharacteristic(
                    characteristic: characteristic,
                    details: $0
                )
            }
            .handleEvents(receiveSubscription: { _ in
                peripheral.readValue(for: coreBluetoothCharacteristic.characteristic)
            })
            .eraseToAnyPublisher()
    }

    func maximumWriteValueLength(for type: CBCharacteristicWriteType) -> Int {
        peripheral.maximumWriteValueLength(for: type)
    }

    func writeValue(_ data: Data, for characteristic: BluetoothCharacteristic, type: CBCharacteristicWriteType) -> AnyPublisher<BluetoothCharacteristic, BluetoothError> {
        guard let coreBluetoothCharacteristic = characteristic as? CoreBluetoothCharacteristic else { return Fail(error: .unknownWrapperType).eraseToAnyPublisher() }
        let peripheral = self.peripheral
        return didWriteValueForCharacteristic
            .tryMap { try $0.get() }
            .filter { $0.id == coreBluetoothCharacteristic.characteristic.id }
            .map(CoreBluetoothCharacteristic.init)
            .mapError {
                BluetoothError.onWriteValueForCharacteristic(
                    characteristic: characteristic,
                    details: $0
                )
            }
            .handleEvents(receiveSubscription: { _ in
                peripheral.writeValue(data, for: coreBluetoothCharacteristic.characteristic, type: type)
            })
            .eraseToAnyPublisher()
    }

    func notifyValue(for characteristic: BluetoothCharacteristic) -> AnyPublisher<BluetoothCharacteristic, BluetoothError> {
        guard let coreBluetoothCharacteristic = characteristic as? CoreBluetoothCharacteristic else {
            return Fail<BluetoothCharacteristic, BluetoothError>(error: .unknownWrapperType).eraseToAnyPublisher()
        }

        let peripheral = self.peripheral
        let readValueForCharacteristic = self.readValueForCharacteristic

        let ensureIsNotifying = didUpdateNotificationStateForCharacteristic
                .compactMap { try? $0.get() }
                .filter { $0.id == coreBluetoothCharacteristic.characteristic.id }
                .map { $0.isNotifying }
                .replaceError(with: false)
                .prepend(coreBluetoothCharacteristic.isNotifying)
                .handleEvents(
                    receiveSubscription: { _ in
                        peripheral.setNotifyValue(true, for: coreBluetoothCharacteristic.characteristic)
                    }
                )
                .eraseToAnyPublisher()

        return ensureIsNotifying
            .mapError(absurd)
            .first(where: { $0 })
            .map { _ in
                readValueForCharacteristic
                    .tryMap { try $0.get() }
                    .filter { $0.id == coreBluetoothCharacteristic.characteristic.id }
                    .map(CoreBluetoothCharacteristic.init)
                    .mapError {
                        BluetoothError.onReadValueForCharacteristic(
                            characteristic: characteristic,
                            details: $0
                        )
                    }
            }
            .switchToLatest()
            .handleEvents(
                receiveCancel: {
                    peripheral.setNotifyValue(false, for: coreBluetoothCharacteristic.characteristic)
                }
            )
            .eraseToAnyPublisher()
    }

    func discoverDescriptors(for characteristic: BluetoothCharacteristic) -> AnyPublisher<BluetoothDescriptor, BluetoothError> {
        guard let coreBluetoothCharacteristic = characteristic as? CoreBluetoothCharacteristic else { return Fail(error: .unknownWrapperType).eraseToAnyPublisher() }
        let peripheral = self.peripheral
        return didDiscoverDescriptors
            .tryMap { try $0.get() }
            .filter { $0.characteristic.id == coreBluetoothCharacteristic.characteristic.id }
            .flatMap { characteristic in
                characteristic
                    .descriptors
                    .map(CoreBluetoothDescriptor.init)
                    .publisher
                    .mapError(absurd)
            }
            .mapError {
                BluetoothError.onDiscoverDescriptors(
                    characteristic: CoreBluetoothCharacteristic(characteristic: coreBluetoothCharacteristic.characteristic),
                    details: $0
                )
            }
            .handleEvents(receiveSubscription: { _ in
                peripheral.discoverDescriptors(for: coreBluetoothCharacteristic.characteristic)
            })
            .eraseToAnyPublisher()
    }

    func readDescriptorValue(_ descriptor: BluetoothDescriptor) -> AnyPublisher<BluetoothDescriptor, BluetoothError> {
        guard let coreBluetoothDescriptor = descriptor as? CoreBluetoothDescriptor else { return Fail(error: .unknownWrapperType).eraseToAnyPublisher() }
        let peripheral = self.peripheral
        return readValueForDescriptor
            .tryMap { try $0.get() }
            .filter { $0.id == coreBluetoothDescriptor.descriptor.id }
            .map(CoreBluetoothDescriptor.init)
            .mapError {
                BluetoothError.onReadValueForDescriptor(
                    descriptor: descriptor,
                    details: $0
                )
            }
            .handleEvents(receiveSubscription: { _ in
                peripheral.readValue(for: coreBluetoothDescriptor.descriptor)
            })
            .eraseToAnyPublisher()
    }

    func writeValue(_ data: Data, for descriptor: BluetoothDescriptor) -> AnyPublisher<BluetoothDescriptor, BluetoothError> {
        guard let coreBluetoothDescriptor = descriptor as? CoreBluetoothDescriptor else { return Fail(error: .unknownWrapperType).eraseToAnyPublisher() }
        let peripheral = self.peripheral
        return didWriteValueForDescriptor
            .tryMap { try $0.get() }
            .filter { $0.id == coreBluetoothDescriptor.descriptor.id }
            .map(CoreBluetoothDescriptor.init)
            .mapError {
                BluetoothError.onWriteValueForDescriptor(
                    descriptor: descriptor,
                    details: $0
                )
            }
            .handleEvents(receiveSubscription: { _ in
                peripheral.writeValue(data, for: coreBluetoothDescriptor.descriptor)
            })
            .eraseToAnyPublisher()
    }

    func openL2CAPChannel(PSM: CBL2CAPPSM) -> AnyPublisher<L2CAPChannel, BluetoothError> {
        let peripheral = self.peripheral
        return didOpenChannel
            .tryMap { try $0.get() }
            .mapError {
                BluetoothError.onOpenChannel(
                    peripheral: CoreBluetoothPeripheral(peripheral: peripheral),
                    PSM: PSM,
                    details: $0
                )
            }
            .handleEvents(receiveSubscription: { _ in
                peripheral.openL2CAPChannel(PSM)
            })
            .eraseToAnyPublisher()
    }
}

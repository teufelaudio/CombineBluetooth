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
    private let didOpenChannel = PassthroughSubject<Result<CBL2CAPChannel, Error>, Never>()
    private let didDiscoverDescriptors = PassthroughSubject<Result<(characteristic: CBCharacteristic, descriptors: [CBDescriptor]), Error>, Never>()
    private let readValueForDescriptor = PassthroughSubject<Result<CBDescriptor, Error>, Never>()
    private let didWriteValueForDescriptor = PassthroughSubject<Result<CBDescriptor, Error>, Never>()

    init(peripheral: CBPeripheral) {
        self.peripheral = peripheral
        super.init()
        self.peripheral.delegate = self
    }
}

extension CoreBluetoothPeripheral: CBPeripheralDelegate {
    func peripheralDidUpdateName(_ peripheral: CBPeripheral) { }
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) { }
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        didReadRSSI.send(error.map(Result.failure) ?? .success(RSSI))
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        didDiscoverServices.send(error.map(Result.failure) ?? .success(peripheral.services ?? []))
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverIncludedServicesFor service: CBService, error: Error?) {
        didDiscoverIncludedServices.send(error.map(Result.failure) ?? .success((parent: service, included: service.includedServices ?? [])))
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        didDiscoverCharacteristics.send(error.map(Result.failure) ?? .success((service: service, characteristics: service.characteristics ?? [])))
    }
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        readValueForCharacteristic.send(error.map(Result.failure) ?? .success(characteristic))
    }
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        didWriteValueForCharacteristic.send(error.map(Result.failure) ?? .success(characteristic))
    }
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        didUpdateNotificationStateForCharacteristic.send(error.map(Result.failure) ?? .success(characteristic))
    }
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        readValueForDescriptor.send(error.map(Result.failure) ?? .success(descriptor))
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        didDiscoverDescriptors.send(error.map(Result.failure) ?? .success((characteristic: characteristic, descriptors: characteristic.descriptors ?? [])))
    }
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
        didWriteValueForDescriptor.send(error.map(Result.failure) ?? .success(descriptor))
    }
    func peripheralIsReady(toSendWriteWithoutResponse peripheral: CBPeripheral) { }
    func peripheral(_ peripheral: CBPeripheral, didOpen channel: CBL2CAPChannel?, error: Error?) {
        didOpenChannel.send(
            error.map(Result.failure)
                ?? channel.map(Result.success)
                ?? Result.failure(NSError(
                    domain: "peripheral(_ peripheral: CBPeripheral, didOpen channel: CBL2CAPChannel?, error: Error?) with both nil",
                    code: -1,
                    userInfo: nil
                ))
        )
    }
}

extension CoreBluetoothPeripheral: BluetoothPeripheral {
    var name: String? { peripheral.name }
    var state: CBPeripheralState { peripheral.state }
    var services: [BluetoothService]? { peripheral.services?.map(CoreBluetoothService.init) }
    var canSendWriteWithoutResponse: Bool { peripheral.canSendWriteWithoutResponse }
    
    func readRSSI() -> Deferred<Future<NSNumber, BluetoothError>> {
        let peripheral = self.peripheral
        return didReadRSSI
            .tryMap { try $0.get() }
            .mapError {
                BluetoothError.onReadRSSI(
                    peripheral: CoreBluetoothPeripheral(peripheral: peripheral),
                    details: $0
                )
            }
            .handleEvents(receiveRequest: { demand in
                guard demand > .none else { return }
                peripheral.readRSSI()
            })
            .first()
            .asDeferredFuture()
    }

    func discoverServices(_ serviceUUIDs: [CBUUID]?) -> Deferred<Future<[BluetoothService], BluetoothError>> {
        let peripheral = self.peripheral
        return didDiscoverServices
            .tryMap { try $0.get() }
            .map { $0.map(CoreBluetoothService.init) }
            .mapError {
                BluetoothError.onDiscoverServices(
                    peripheral: CoreBluetoothPeripheral(peripheral: peripheral),
                    details: $0
                )
            }
            .handleEvents(receiveRequest: { demand in
                guard demand > .none else { return }
                peripheral.discoverServices(serviceUUIDs)
            })
            .first()
            .asDeferredFuture()
    }

    func discoverIncludedServices(_ includedServiceUUIDs: [CBUUID]?, for service: CBService) -> Deferred<Future<[BluetoothService], BluetoothError>> {
        let peripheral = self.peripheral
        return didDiscoverIncludedServices
            .tryMap { try $0.get() }
            .filter { $0.parent == service }
            .map { $0.included.map(CoreBluetoothService.init) }
            .mapError {
                BluetoothError.onDiscoverIncludedServices(
                    service: CoreBluetoothService(service: service),
                    details: $0
                )
            }
            .handleEvents(receiveRequest: { demand in
                guard demand > .none else { return }
                peripheral.discoverIncludedServices(includedServiceUUIDs, for: service)
            })
            .first()
            .asDeferredFuture()
    }

    func discoverCharacteristics(_ characteristicUUIDs: [CBUUID]?, for service: BluetoothService) -> Deferred<Future<[BluetoothCharacteristic], BluetoothError>> {
        guard let coreBluetoothService = service as? CoreBluetoothService else { return .failure(.unknownWrapperType) }
        let peripheral = self.peripheral
        return didDiscoverCharacteristics
            .tryMap { try $0.get() }
            .filter { $0.service == coreBluetoothService.service }
            .map { $0.characteristics.map(CoreBluetoothCharacteristic.init) }
            .mapError {
                BluetoothError.onDiscoverCharacteristics(
                    service: CoreBluetoothService(service: coreBluetoothService.service),
                    details: $0
                )
            }
            .handleEvents(receiveRequest: { demand in
                guard demand > .none else { return }
                peripheral.discoverCharacteristics(characteristicUUIDs, for: coreBluetoothService.service)
            })
            .first()
            .asDeferredFuture()
    }

    func readValue(for characteristic: BluetoothCharacteristic) -> Deferred<Future<BluetoothCharacteristic, BluetoothError>> {
        guard let coreBluetoothCharacteristic = characteristic as? CoreBluetoothCharacteristic else { return .failure(.unknownWrapperType) }
        let peripheral = self.peripheral
        return readValueForCharacteristic
            .tryMap { try $0.get() }
            .filter { $0 == coreBluetoothCharacteristic.characteristic }
            .map(CoreBluetoothCharacteristic.init)
            .mapError {
                BluetoothError.onReadValueForCharacteristic(
                    characteristic: characteristic,
                    details: $0
                )
            }
            .handleEvents(receiveRequest: { demand in
                guard demand > .none else { return }
                peripheral.readValue(for: coreBluetoothCharacteristic.characteristic)
            })
            .first()
            .asDeferredFuture()
    }

    func maximumWriteValueLength(for type: CBCharacteristicWriteType) -> Int {
        peripheral.maximumWriteValueLength(for: type)
    }

    func writeValue(_ data: Data, for characteristic: BluetoothCharacteristic, type: CBCharacteristicWriteType) -> Deferred<Future<BluetoothCharacteristic, BluetoothError>> {
        guard let coreBluetoothCharacteristic = characteristic as? CoreBluetoothCharacteristic else { return .failure(.unknownWrapperType) }
        let peripheral = self.peripheral
        return didWriteValueForCharacteristic
            .tryMap { try $0.get() }
            .filter { $0 == coreBluetoothCharacteristic.characteristic }
            .map(CoreBluetoothCharacteristic.init)
            .mapError {
                BluetoothError.onWriteValueForCharacteristic(
                    characteristic: characteristic,
                    details: $0
                )
            }
            .handleEvents(receiveRequest: { demand in
                guard demand > .none else { return }
                peripheral.writeValue(data, for: coreBluetoothCharacteristic.characteristic, type: type)
            })
            .first()
            .asDeferredFuture()
    }

    func notifyValue(for characteristic: BluetoothCharacteristic) -> AnyPublisher<BluetoothCharacteristic, BluetoothError> {
        guard let coreBluetoothCharacteristic = characteristic as? CoreBluetoothCharacteristic else {
            return Fail<BluetoothCharacteristic, BluetoothError>(error: .unknownWrapperType).eraseToAnyPublisher()
        }

        let peripheral = self.peripheral
        let readValueForCharacteristic = self.readValueForCharacteristic

        let isNotifying = coreBluetoothCharacteristic.isNotifying
            ? Just(()).eraseToAnyPublisher()
            : didUpdateNotificationStateForCharacteristic
                .filter {
                    guard let characteristicNotificationState = try? $0.get() else { return false }
                    guard characteristicNotificationState == coreBluetoothCharacteristic.characteristic else { return false }
                    guard characteristicNotificationState.isNotifying else { return false }
                    return true
                }
                .map { _ in () }
                .handleEvents(receiveRequest: { demand in
                    guard demand > .none else { return }
                    peripheral.setNotifyValue(true, for: coreBluetoothCharacteristic.characteristic)
                })
                .eraseToAnyPublisher()

        return isNotifying
            .mapError { _ in BluetoothError.noLongerDelegate }
            .map {
                readValueForCharacteristic
                    .tryMap { try $0.get() }
                    .filter { $0 == coreBluetoothCharacteristic.characteristic }
                    .map(CoreBluetoothCharacteristic.init)
                    .mapError {
                        BluetoothError.onReadValueForCharacteristic(
                            characteristic: characteristic,
                            details: $0
                        )
                    }
                    .handleEvents(
                        receiveCompletion: { _ in
                            peripheral.setNotifyValue(false, for: coreBluetoothCharacteristic.characteristic)
                        },
                        receiveRequest: { demand in
                            guard demand > .none else { return }
                            peripheral.readValue(for: coreBluetoothCharacteristic.characteristic)
                        }
                    )
            }
            .switchToLatest()
            .eraseToAnyPublisher()
    }

    func discoverDescriptors(for characteristic: BluetoothCharacteristic) -> Deferred<Future<[BluetoothDescriptor], BluetoothError>> {
        guard let coreBluetoothCharacteristic = characteristic as? CoreBluetoothCharacteristic else { return .failure(.unknownWrapperType) }

        let peripheral = self.peripheral
        return didDiscoverDescriptors
            .tryMap { try $0.get() }
            .filter { $0.characteristic == coreBluetoothCharacteristic.characteristic }
            .map { $0.descriptors.map(CoreBluetoothDescriptor.init) }
            .mapError {
                BluetoothError.onDiscoverDescriptors(
                    characteristic: CoreBluetoothCharacteristic(characteristic: coreBluetoothCharacteristic.characteristic),
                    details: $0
                )
            }
            .handleEvents(receiveRequest: { demand in
                guard demand > .none else { return }
                peripheral.discoverDescriptors(for: coreBluetoothCharacteristic.characteristic)
            })
            .first()
            .asDeferredFuture()
    }

    func readValue(for descriptor: BluetoothDescriptor) -> Deferred<Future<BluetoothDescriptor, BluetoothError>> {
        guard let coreBluetoothDescriptor = descriptor as? CoreBluetoothDescriptor else { return .failure(.unknownWrapperType) }
        let peripheral = self.peripheral
        return readValueForDescriptor
            .tryMap { try $0.get() }
            .filter { $0 == coreBluetoothDescriptor.descriptor }
            .map(CoreBluetoothDescriptor.init)
            .mapError {
                BluetoothError.onReadValueForDescriptor(
                    descriptor: descriptor,
                    details: $0
                )
            }
            .handleEvents(receiveRequest: { demand in
                guard demand > .none else { return }
                peripheral.readValue(for: coreBluetoothDescriptor.descriptor)
            })
            .first()
            .asDeferredFuture()
    }

    func writeValue(_ data: Data, for descriptor: BluetoothDescriptor) -> Deferred<Future<BluetoothDescriptor, BluetoothError>> {
        guard let coreBluetoothDescriptor = descriptor as? CoreBluetoothDescriptor else { return .failure(.unknownWrapperType) }
        let peripheral = self.peripheral
        return didWriteValueForDescriptor
            .tryMap { try $0.get() }
            .filter { $0 == coreBluetoothDescriptor.descriptor }
            .map(CoreBluetoothDescriptor.init)
            .mapError {
                BluetoothError.onWriteValueForDescriptor(
                    descriptor: descriptor,
                    details: $0
                )
            }
            .handleEvents(receiveRequest: { demand in
                guard demand > .none else { return }
                peripheral.writeValue(data, for: coreBluetoothDescriptor.descriptor)
            })
            .first()
            .asDeferredFuture()
    }

    func openL2CAPChannel(PSM: CBL2CAPPSM) -> Deferred<Future<CBL2CAPChannel, BluetoothError>> {
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
            .handleEvents(receiveRequest: { demand in
                guard demand > .none else { return }
                peripheral.openL2CAPChannel(PSM)
            })
            .first()
            .asDeferredFuture()
    }
}

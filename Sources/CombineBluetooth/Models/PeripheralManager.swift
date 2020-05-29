import Combine
import CoreBluetooth

// sourcery: AutoMockable
public protocol PeripheralManager: BluetoothManager {
    var isAdvertising: AnyPublisher<Bool, Never> { get }
    var isReadyAgainForWriteWithoutResponse: AnyPublisher<Void, Never> { get }
    func startAdvertising() -> AnyPublisher<Void, BluetoothError>
    func startAdvertising(advertisementData: [String: Any]) -> AnyPublisher<Void, BluetoothError>
    func setDesiredConnectionLatency(_ latency: CBPeripheralManagerConnectionLatency, for central: BluetoothCentral) -> Result<Void, BluetoothError>
    func add(_ service: BluetoothService) -> Promise<BluetoothService, BluetoothError>
    func remove(_ service: BluetoothService) -> Result<BluetoothService, BluetoothError>
    func removeAllServices()
    func respond(to request: ATTRequest, withResult result: CBATTError.Code) -> Result<Void, BluetoothError>
    func updateValue(_ value: Data, for characteristic: BluetoothCharacteristic, onSubscribedCentrals centrals: [BluetoothCentral]?) -> Result<Bool, BluetoothError>
    func publishL2CAPChannel(withEncryption encryptionRequired: Bool) -> Promise<CBL2CAPPSM, BluetoothError>
    func unpublishL2CAPChannel(_ PSM: CBL2CAPPSM)  -> Promise<CBL2CAPPSM, BluetoothError>
}

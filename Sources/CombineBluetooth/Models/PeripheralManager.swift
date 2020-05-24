import Combine
import CoreBluetooth

public protocol PeripheralManager: BluetoothManager {
    var isAdvertising: AnyPublisher<Bool, Never> { get }
    var isReadyAgainForWriteWithoutResponse: AnyPublisher<Void, Never> { get }
    func startAdvertising() -> AnyPublisher<Void, BluetoothError>
    func startAdvertising(_ advertisementData: [String: Any]) -> AnyPublisher<Void, BluetoothError>
    func setDesiredConnectionLatency(_ latency: CBPeripheralManagerConnectionLatency, for central: BluetoothCentral) -> Result<Void, BluetoothError>
    func add(_ service: BluetoothService) -> Deferred<Future<BluetoothService, BluetoothError>>
    func remove(_ service: BluetoothService) -> Result<BluetoothService, BluetoothError>
    func removeAllServices()
    func respond(to request: ATTRequest, withResult result: CBATTError.Code) -> Result<Void, BluetoothError>
    func updateValue(_ value: Data, for characteristic: BluetoothCharacteristic, onSubscribedCentrals centrals: [BluetoothCentral]?) -> Result<Bool, BluetoothError>
    func publishL2CAPChannel(withEncryption encryptionRequired: Bool) -> Deferred<Future<CBL2CAPPSM, BluetoothError>>
    func unpublishL2CAPChannel(_ PSM: CBL2CAPPSM)  -> Deferred<Future<CBL2CAPPSM, BluetoothError>>
}

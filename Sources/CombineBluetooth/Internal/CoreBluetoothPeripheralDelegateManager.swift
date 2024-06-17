import CoreBluetooth
import Foundation

class CoreBluetoothPeripheralDelegateManager: NSObject, CBPeripheralDelegate {
    private let multicastDelegate = MulticastDelegate<CBPeripheralDelegate>()
    
    weak var delegate: CBPeripheralDelegate? {
        get {
            guard !multicastDelegate.isEmpty else { return nil }
            return self
        }
        set {
            guard let newValue else { return }
            multicastDelegate.add(newValue)
        }
    }
    
    func peripheralDidUpdateName(_ peripheral: CBPeripheral) {
        multicastDelegate.invoke { $0.peripheralDidUpdateName?(peripheral) }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
        multicastDelegate.invoke { $0.peripheral?(peripheral, didModifyServices: invalidatedServices) }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        multicastDelegate.invoke { $0.peripheral?(peripheral, didReadRSSI: RSSI, error: error) }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        multicastDelegate.invoke { $0.peripheral?(peripheral, didDiscoverServices: error) }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverIncludedServicesFor service: CBService, error: Error?) {
        multicastDelegate.invoke { $0.peripheral?(peripheral, didDiscoverIncludedServicesFor: service, error: error) }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        multicastDelegate.invoke { $0.peripheral?(peripheral, didDiscoverCharacteristicsFor: service, error: error) }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        multicastDelegate.invoke { $0.peripheral?(peripheral, didUpdateValueFor: characteristic, error: error) }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        multicastDelegate.invoke { $0.peripheral?(peripheral, didWriteValueFor: characteristic, error: error) }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        multicastDelegate.invoke { $0.peripheral?(peripheral, didUpdateNotificationStateFor: characteristic, error: error) }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        multicastDelegate.invoke { $0.peripheral?(peripheral, didUpdateValueFor: descriptor, error: error) }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        multicastDelegate.invoke { $0.peripheral?(peripheral, didDiscoverDescriptorsFor: characteristic, error: error) }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
        multicastDelegate.invoke { $0.peripheral?(peripheral, didWriteValueFor: descriptor, error: error) }
    }
    
    func peripheralIsReady(toSendWriteWithoutResponse peripheral: CBPeripheral) {
        multicastDelegate.invoke { $0.peripheralIsReady?(toSendWriteWithoutResponse: peripheral) }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didOpen channel: CBL2CAPChannel?, error: Error?) {
        multicastDelegate.invoke { $0.peripheral?(peripheral, didOpen: channel, error: error) }
    }
}

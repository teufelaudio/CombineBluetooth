// Copyright © 2024 Lautsprecher Teufel GmbH. All rights reserved.

import CoreBluetooth
import Foundation

/*
This protocol has no AutoMockable annotation for a reason, for further epxlanation see
it's mock in CombineBluetoothMocks > CentralManagerDependencyMock. 
*/

@objc 
public protocol CentralManagerDependency where Self: NSObject {
    var state: CBManagerState { get }
    var delegate: CBCentralManagerDelegate? { get set }
    var isScanning: Bool { get }
    func stopScan() -> Void
    func scanForPeripherals(withServices: [CBUUID]?, options: [String : Any]?) -> Void
    // Adding the Objective-c selector here as the resolving from swift is not matching
    @objc(connectPeripheral:options:) func connect(_ peripheral: CBPeripheral, options: [String: Any]?)
    func cancelPeripheralConnection(_ peripheral: CBPeripheral) -> Void
    func retrievePeripherals(withIdentifiers: [UUID]) -> [CBPeripheral]
    func retrieveConnectedPeripherals(withServices: [CBUUID]) -> [CBPeripheral]
}

extension CBCentralManager: CentralManagerDependency {}

# CombineBluetooth
Combine extensions for CoreBluetooth

## Usage

Scanning:
```swift
import Combine
import CombineBluetooth
import CombineExt // https://github.com/CombineCommunity/CombineExt.git
import CoreBluetooth
import Foundation

enum AppError: Error {
    case bluetoothRadioTimeoout
    case bluetoothScanTimeout
    case bluetoothError(BluetoothError)
}

let centralManager = CBCentralManager().combine

let cancellable = Publishers
    .Amb(
        first: centralManager
            .state
            .filter { $0 == .poweredOn }
            .mapError(AppError.bluetoothError),

        second: Fail(error: AppError.bluetoothRadioTimeoout)
            .delay(for: 5, scheduler: DispatchQueue.main)
    )
    .map { _ in
        Publishers.Merge(
            centralManager
                .scanForPeripherals(withServices: [])
                .mapError(AppError.bluetoothError)
                .eraseToAnyPublisher(),

            Fail(error: AppError.bluetoothScanTimeout)
                .delay(for: 15, scheduler: DispatchQueue.main)
        )
    }
    .switchToLatest()
    .scan([AdvertisingPeripheral]()) { list, device in
        guard let name = device.peripheral.name else { return list }
        return list
            .filter { $0.peripheral.name != name } + [device]
            .sorted(by: { l, r in l.rssi.intValue > r.rssi.intValue })
    }
    .removeDuplicates(by: { l, r in l.count == r.count })
    .sink(
        receiveCompletion: { completion in
            switch completion {
            case .failure(.bluetoothRadioTimeoout):
                print("Bluetooth radio timeout, please ensure Bluetooth is on and this app is allowed to use it")
            case .failure(.bluetoothScanTimeout):
                print("Scan completed!")
            case let .failure(.bluetoothError(error)):
                print("Oops, bluetooth error: \(error)")
            case .finished:
                print("Scan cancelled")
            }
        },
        receiveValue: { adv in
            print("Found devices: \(adv.map { "(name: \($0.peripheral.name ?? ""), rssi: \($0.rssi))" }.joined(separator: ", "))")
        }
    )

```

## Installation

Static / automatic:
```swift
// swift-tools-version:5.2
import PackageDescription

let package = Package(
  name: "MyApp",
  platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)],
  products: [
    .executable(name: "MyApp", targets: ["MyApp"])
  ],
  dependencies: [
    .package(url: "https://github.com/luizmb/CombineBluetooth.git", .branch("master"))
  ],
  targets: [
    .target(name: "MyApp", dependencies: [.product(name: "CombineBluetooth", package: "CombineBluetooth")])
  ]
)
```

Dynamic (when Xcode can't resolve diamond dependency properly):
```swift
// swift-tools-version:5.2
import PackageDescription

let package = Package(
  name: "MyApp",
  platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)],
  products: [
    .executable(name: "MyApp", targets: ["MyApp"])
  ],
  dependencies: [
    .package(url: "https://github.com/luizmb/CombineBluetooth.git", .branch("master"))
  ],
  targets: [
    .target(name: "MyApp", dependencies: [.product(name: "CombineBluetoothDynamic", package: "CombineBluetooth")])
  ]
)
```

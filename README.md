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
    // Amb is a race between two (or more) Publishers.
    // This is totally optional, we use it here to timeout
    // after 5 seconds if we don't get bluetooth clearance.
    .Amb(
        // race is between a clearance (.poweredOn state)
        first: centralManager
            .state
            .filter { $0 == .poweredOn }
            .mapError(AppError.bluetoothError),

        // and a hardcoded failure that will be delayed by 5 seconds
        // which is the time we give to the other publisher to get
        // into the expected state
        second: Fail(error: AppError.bluetoothRadioTimeoout)
            .delay(for: 5, scheduler: DispatchQueue.main)
    )
    .map { _ in
        // Once we know Central Manager is ready, we don't care
        // about the upstream value any more. Let's start a new
        // Let's scan for 15 seconds, this time instead of using
        // Amb, let's use Merge because we want the timeout
        // regardless of successful values published by the scan.
        // In other words, this timeout will EVER happen.
        // This is an example use case, you don't have to do this
        // way. :-)
        Publishers.Merge(
            // We merge a scan for peripherals operation
            centralManager
                .scanForPeripherals(withServices: [])
                .mapError(AppError.bluetoothError)
                .eraseToAnyPublisher(),

            // and a timeout completion delayed by 15 seconds
            Fail(error: AppError.bluetoothScanTimeout)
                .delay(for: 15, scheduler: DispatchQueue.main)
        )
    }
    // map + switchToLatest ==> flatMapLatest
    .switchToLatest()
    // Sorry that this is called scan, but it has nothing to
    // do with Bluetooth scanning, it's the Combine scan to reduce
    // individual results into an Array.
    .scan([AdvertisingPeripheral]()) { list, device in
        // A very silly logic to identify by the peripheral name.
        // Please don't do that :D
        guard let name = device.peripheral.name else { return list }
        return list
            .filter { $0.peripheral.name != name } + [device]
            // and sorted by the latest rssi, again, silly.
            .sorted(by: { l, r in l.rssi.intValue > r.rssi.intValue })
    }
    // Here we avoid too many events, by simply counting the previous
    // event number of peripherals with the new one. This will exclude
    // RSSI changes, so maybe you don't want that.
    .removeDuplicates(by: { l, r in l.count == r.count })
    .sink(
        receiveCompletion: { completion in
            // The timeouts are expected and triggered by this app
            // Anything else, triggered by the CombineBluetooth library
            // should be caught by your app to identify real problems.
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
            // Tell the user the last known list of Peripherals
            // In a real app you may want to update a CurrentValueSubject,
            // your redux state, your views, etc. Or connect to the best
            // one. This is up to you 👹
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

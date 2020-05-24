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

## Tests and Mocks

CombineBluetooth is written as a Protocol-Oriented library and all its models are protocols or simple enums/structs. Internally,
this is resolved to CoreBluetooth entities, but if, instead of spreading CoreBluetooth entities all over your app you go for the
protocols this library offer, then testing your app will be much easier. We even offer a mock library as a Swift Package Manager
product (CombineBluetoothMocks or CombineBluetoothMocksDynamic) with Sourcery's auto-mockable ready-to-be-used classes. You can
also use your own Sourcery templates if you want, or write mocks manually, it's up to you.

For example, a `CentralManager` protocol requires a class or struct having, among other members, the following method:
```swift
func scanForPeripherals() -> AnyPublisher<AdvertisingPeripheral, BluetoothError>
```

Because `AdvertisingPeripheral` is another protocol, it should be easy for you to pretend your scanning for peripherals is
returning data that would otherwise be impossible during tests. This also opens up possibilities such as "demo mode" for apps
using CoreBluetooth.

For using the AutoMockable entities you have several options, for example, pretending a function returns some values:
```swift
let centralManager = CentralManagerMock()
centralManager.scanForPeripheralsReturnValue = [dev1, dev2, dev3].publisher.mapError { $0 }.eraseToAnyPublisher()
sut.runScan(centralManager: centralManager)
```

```swift
let centralManager = CentralManagerMock()
centralManager.scanForPeripheralsClosure = {
    // with closure option you can assert that the function was called
    expectation.fulfil()
    return [dev1, dev2, dev3].publisher.mapError { $0 }.eraseToAnyPublisher()
}
sut.runScan(centralManager: centralManager)
```

For properties you can set `mock.underlyingProperty` before a function that uses it is called. You can also assert
that certain function was called, or even how many times it was called. When a function is called and it receives
parameters, these parameters are stored in an array that can be asserted later. These arrays are not type-safe but
for tests this is probably the behaviour you want, so you control the race conditions in your tests and avoid them
in runtime.

For more information, please check the auto-generated mocks file source code.
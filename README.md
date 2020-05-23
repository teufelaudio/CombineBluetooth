# CombineBluetooth
Combine extensions for CoreBluetooth

## Usage
TBD

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

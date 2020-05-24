// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "CombineBluetooth",
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
        .library(name: "CombineBluetooth", targets: ["CombineBluetooth"]),
        .library(name: "CombineBluetoothDynamic", type: .dynamic, targets: ["CombineBluetooth"]),
        .library(name: "CombineBluetoothMocks", targets: ["CombineBluetoothMocks"])
    ],
    targets: [
        .target(name: "CombineBluetooth"),
        .target(name: "CombineBluetoothMocks", dependencies: ["CombineBluetooth"])
    ]
)

// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RehberimBenimleCoreKit",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        
        .library(
            name: "RehberimBenimleCoreKit",
            targets: ["RehberimBenimleCoreKit"]
        ),
    ],
    targets: [
        .target(
            name: "RehberimBenimleCoreKit"
        ),
        .testTarget(
            name: "RehberimBenimleCoreKitTests",
            dependencies: ["RehberimBenimleCoreKit"]
        ),
    ]
)

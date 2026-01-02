// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RehberimBenimleFeatures",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "RehberimBenimleFeatures",
            targets: ["RehberimBenimleFeatures"]
        ),
    ],
    dependencies: [
        .package(path: "../RehberimBenimleCoreKit"),
        .package(path: "../RehberimBenimleUI")
    ],
    targets: [
        .target(
            name: "RehberimBenimleFeatures",
            dependencies: [
                "RehberimBenimleCoreKit",
                "RehberimBenimleUI"
            ]
        ),
        .testTarget(
            name: "RehberimBenimleFeaturesTests",
            dependencies: ["RehberimBenimleFeatures"]
        ),
    ]
)

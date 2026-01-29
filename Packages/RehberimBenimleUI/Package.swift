// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RehberimBenimleUI",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "RehberimBenimleUI",
            targets: ["RehberimBenimleUI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.7.1"),
        .package(path: "../RehberimBenimleCoreKit")
    ],
    targets: [
        .target(
            name: "RehberimBenimleUI",
            dependencies: [
                .product(name: "SnapKit", package: "SnapKit"),
                "RehberimBenimleCoreKit"
            ],
            path: "Sources/RehberimBenimleUI"
        ),
        .testTarget(
            name: "RehberimBenimleUITests",
            dependencies: ["RehberimBenimleUI"]
        ),
    ]
)

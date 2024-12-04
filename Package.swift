// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ScreenGuard",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "ScreenGuard",
            targets: ["ScreenGuard"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ScreenGuard"
        ),
        .testTarget(
            name: "ScreenGuardTests",
            dependencies: ["ScreenGuard"]
        )
    ]
)

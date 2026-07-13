// swift-tools-version: 6.3.3

// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-throttling-dependencies open source project
//
// Copyright (c) 2026 Coen ten Thije Boonkkamp and the swift-throttling-dependencies
// project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

import PackageDescription

let package = Package(
    name: "swift-throttling-dependencies",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        // The throttling × dependencies integration: rate-limiter, pacer, and
        // throttled-client entry points that read the current instant from the
        // `\.date` dependency.
        .library(
            name: "Throttling Dependencies",
            targets: ["Throttling Dependencies"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/swift-foundations/swift-throttling.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-clocks-dependencies.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-dependencies.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Throttling Dependencies",
            dependencies: [
                .product(name: "Throttling", package: "swift-throttling"),
                .product(name: "Clocks Dependencies", package: "swift-clocks-dependencies"),
                .product(name: "Dependencies", package: "swift-dependencies"),
            ]
        ),
        .testTarget(
            name: "Throttling Dependencies Tests",
            dependencies: [
                "Throttling Dependencies",
                .product(name: "Dependencies Test Support", package: "swift-dependencies"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}

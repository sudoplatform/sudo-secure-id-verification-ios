// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SudoIdentityVerification",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "SudoIdentityVerification",
            targets: ["SudoIdentityVerification"]),
    ],
    dependencies: [
        .package(url: "https://github.com/sudoplatform/sudo-api-client-ios", from: "14.0.0"),
        .package(url: "https://github.com/sudoplatform/sudo-config-manager-ios", from: "6.0.0"),
        .package(url: "https://github.com/sudoplatform/sudo-logging-ios", from: "3.0.0"),
        .package(url: "https://github.com/sudoplatform/sudo-user-ios", from: "19.0.0"),
        .package(url: "https://github.com/aws-amplify/amplify-swift", from: "2.49.1"),
    ],
    targets: [
        .target(
            name: "SudoIdentityVerification",
            dependencies: [
                .product(name: "SudoApiClient", package: "sudo-api-client-ios"),
                .product(name: "SudoConfigManager", package: "sudo-config-manager-ios"),
                .product(name: "SudoLogging", package: "sudo-logging-ios"),
                .product(name: "SudoUser", package: "sudo-user-ios"),
            ],
            path: "SudoIdentityVerification/",
            swiftSettings: [.swiftLanguageMode(.v5)]
        ),
    ]
)

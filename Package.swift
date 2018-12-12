// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Sketch2Code",
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", .exact("0.40200.0")),
        .package(url: "https://github.com/weichsel/ZIPFoundation/", .upToNextMajor(from: "0.9.0"))
    ],
    targets: [
        .target(
            name: "Sketch2Code",
            dependencies: [
                "SwiftSyntax",
                "ZIPFoundation"
            ]),
        .testTarget(
            name: "Sketch2CodeTests",
            dependencies: [
                "Sketch2Code"
            ]),
    ]
)

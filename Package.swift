// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Sketch2Code",
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", .exact("0.40200.0")),
    ],
    targets: [
        .target(
            name: "Sketch2Code",
            dependencies: [
                "SwiftSyntax",
            ]),
        .testTarget(
            name: "Sketch2CodeTests",
            dependencies: ["Sketch2Code"]),
    ]
)

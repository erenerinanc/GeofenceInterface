// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GeofenceInterface",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "GeofenceInterface",
            targets: ["GeofenceInterface"]),
    ],
    targets: [
        .target(
            name: "GeofenceInterface"),
        .testTarget(
            name: "GeofenceInterfaceTests",
            dependencies: ["GeofenceInterface"]
        ),
    ]
)


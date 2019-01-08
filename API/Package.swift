// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "API",
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),



        .package(url: "https://github.com/IgorMuzyka/Tyler.git", .branch("master")),

        .package(url: "https://github.com/IgorMuzyka/Tyler.Identifier.git", .branch("master")),
        .package(url: "https://github.com/IgorMuzyka/Tyler.Tag.git", .branch("master")),
        .package(url: "https://github.com/IgorMuzyka/Tyler.Variable.git", .branch("master")),
        .package(url: "https://github.com/IgorMuzyka/Tyler.Style.git", .branch("master")),
        .package(url: "https://github.com/IgorMuzyka/Tyler.Anchor.git", .branch("master")),
        .package(url: "https://github.com/IgorMuzyka/Tyler.Action.git", .branch("master")),

        .package(url: "https://github.com/IgorMuzyka/Tyler.Substitutes.git", .branch("master")),
        .package(url: "https://github.com/IgorMuzyka/Tyler.Support.Apple.Common.git", .branch("master")),
        .package(url: "https://github.com/IgorMuzyka/Tyler.Support.Apple.UIKit.git", .branch("master")),
    ],
    targets: [
        .target(name: "App", dependencies: [
            "FluentSQLite", "Vapor",
            "Tyler", "Tyler.Identifier", "Tyler.Tag", "Tyler.Variable", "Tyler.Style", "Tyler.Anchor", "Tyler.Action",
            "Tyler.Substitutes", "Tyler.Support.Apple.Common", "Tyler.Support.Apple.UIKit"
        ]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)


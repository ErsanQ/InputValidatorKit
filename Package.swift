// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "InputValidatorKit",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "InputValidatorKit",
            targets: ["InputValidatorKit"]
        ),
    ],
    targets: [
        .target(
            name: "InputValidatorKit",
            path: "Sources/InputValidatorKit"
        )
    ]
)

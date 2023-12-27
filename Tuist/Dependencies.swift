// swift-tools-version: 5.7
import ProjectDescription

let dependencies = Dependencies(
	swiftPackageManager: .init(
		productTypes: [
			"TaskManagerPackage": .framework
		],
		baseSettings: .settings(base: ["GENERATE_INFOPLIST_FILE": "YES"])
	),
	platforms: [.iOS]
)

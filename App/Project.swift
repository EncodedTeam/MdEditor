import ProjectDescription

// MARK: - Project

private let organization = "EncodedTeam"
private let projectName = "MdEditor"

private var bundleId: String {
	"com.encoders.\(projectName)"
}

private var swiftLintTargetScript: TargetScript {
	let swiftLintScriptString = """
		export PATH="$PATH:/opt/homebrew/bin"
		if which swiftlint > /dev/null; then
		  swiftlint
		else
		  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
		  exit 1
		fi
		"""

	return TargetScript.pre(
		script: swiftLintScriptString,
		name: "Run SwiftLint",
		basedOnDependencyAnalysis: false
	)
}

private let scripts: [TargetScript] = [
	swiftLintTargetScript
]

let project = Project(
	name: projectName,
	organizationName: organization,
	options: .options(
		disableBundleAccessors: true,
		disableSynthesizedResourceAccessors: false
	),
	packages: [
		.local(path: .relativeToManifest("../Packages/TaskManagerPackage")),
		.local(path: .relativeToManifest("../Packages/DataStructuresPackage"))
	],
	targets: [
		Target(
			name: projectName,
			destinations: .iOS,
			product: .app,
			bundleId: bundleId,
			deploymentTargets: .iOS("16.0"),
			infoPlist: "\(projectName)/Environments/Info.plist",
			sources: ["\(projectName)/Sources/**"],
			resources: ["\(projectName)/Resources/**"],
			scripts: scripts,
			dependencies: [
				.package(product: "TaskManagerPackage", type: .runtime),
				.package(product: "DataStructuresPackage", type: .runtime)
			]
		),
		Target(
			name: "\(projectName)Tests",
			destinations: .iOS,
			product: .unitTests,
			bundleId: "\(bundleId)Tests",
			deploymentTargets: .iOS("16.0"),
			infoPlist: .none,
			sources: ["\(projectName)Tests/**"],
			dependencies: [
				.target(name: "\(projectName)")
			],
			settings: .settings(base: ["GENERATE_INFOPLIST_FILE": "YES"])
		),
		Target(
			name: "\(projectName)UITests",
			destinations: .iOS,
			product: .uiTests,
			bundleId: "\(bundleId)UITests",
			deploymentTargets: .iOS("16.0"),
			infoPlist: .none,
			sources: ["\(projectName)UITests/**", "Derived/Sources/**"],
			dependencies: [
				.target(name: "\(projectName)")
			],
			settings: .settings(base: ["GENERATE_INFOPLIST_FILE": "YES"])
		)
	]
)

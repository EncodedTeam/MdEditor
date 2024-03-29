import ProjectDescription

// MARK: - Project

enum ProjectSettings {
	public static var organizationName: String { "EncodedTeam" }
	public static var projectName: String { "MdEditor" }
	public static var targerVersion: String { "15.0" }
	public static var bundleId: String { "com.\(organizationName).\(projectName)" }
	public static var marketingVersion: String { "$(VERSION)" }
	public static var currentProjectVersion: String { "$(BUILD_NUMBER)" }
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

private let preActionScriptForRun = """
	cd "$SRCROOT/$PRODUCT_NAME/Environments"
	source Version.sh
	"""

let project = Project(
	name: ProjectSettings.projectName,
	organizationName: ProjectSettings.organizationName,
	options: .options(
		defaultKnownRegions: ["Base", "en", "ru"],
		developmentRegion: "en",
		disableBundleAccessors: true,
		disableSynthesizedResourceAccessors: false
	),
	packages: [
		.local(path: .relativeToManifest("../Packages/TaskManagerPackage")),
		.local(path: .relativeToManifest("../Packages/DataStructuresPackage")),
		.local(path: .relativeToManifest("../Packages/MarkdownPackage")),
		.local(path: .relativeToManifest("../Packages/NetworkLayerPackage"))
	],
	settings: .settings(
		base: SettingsDictionary()
			.appleGenericVersioningSystem()
			.marketingVersion(ProjectSettings.marketingVersion)
			.currentProjectVersion(ProjectSettings.currentProjectVersion)
	),
	targets: [
		Target(
			name: ProjectSettings.projectName,
			destinations: .iOS,
			product: .app,
			bundleId: ProjectSettings.bundleId,
			deploymentTargets: .iOS(ProjectSettings.targerVersion),
			infoPlist: "\(ProjectSettings.projectName)/Environments/Info.plist",
			sources: ["\(ProjectSettings.projectName)/Sources/**", "\(ProjectSettings.projectName)/Shared/**"],
			resources: [
				"\(ProjectSettings.projectName)/Resources/**",
				.folderReference(path: "\(ProjectSettings.projectName)/Assets")
			],
			scripts: scripts,
			dependencies: [
				.package(product: "TaskManagerPackage", type: .runtime),
				.package(product: "DataStructuresPackage", type: .runtime),
				.package(product: "MarkdownPackage", type: .runtime),
				.package(product: "NetworkLayerPackage", type: .runtime)
			],
			settings: .settings(configurations: [
				.debug(name: "Debug", xcconfig: "\(ProjectSettings.projectName)/Environments/Config.xcconfig"),
				.release(name: "Release", xcconfig: "\(ProjectSettings.projectName)/Environments/Config.xcconfig")
			])
		),
		Target(
			name: "\(ProjectSettings.projectName)Tests",
			destinations: .iOS,
			product: .unitTests,
			bundleId: "\(ProjectSettings.bundleId)Tests",
			deploymentTargets: .iOS(ProjectSettings.targerVersion),
			infoPlist: .none,
			sources: ["\(ProjectSettings.projectName)Tests/**"],
			scripts: scripts,
			dependencies: [
				.target(name: "\(ProjectSettings.projectName)")
			],
			settings: .settings(base: ["GENERATE_INFOPLIST_FILE": "YES"])
		),
		Target(
			name: "\(ProjectSettings.projectName)UITests",
			destinations: .iOS,
			product: .uiTests,
			bundleId: "\(ProjectSettings.bundleId)UITests",
			deploymentTargets: .iOS(ProjectSettings.targerVersion),
			infoPlist: .none,
			sources: [
				"\(ProjectSettings.projectName)UITests/**", 
				"\(ProjectSettings.projectName)/Shared/**"
			],
			resources: ["\(ProjectSettings.projectName)/Resources/**"],
			scripts: scripts,
			dependencies: [
				.target(name: "\(ProjectSettings.projectName)")
			],
			settings: .settings(base: ["GENERATE_INFOPLIST_FILE": "YES"])
		)
	],
	schemes: [
		Scheme(
			name: ProjectSettings.projectName,
			shared: true,
			buildAction: .buildAction(targets: ["\(ProjectSettings.projectName)"]),
			testAction: .targets([
				"\(ProjectSettings.projectName)Tests",
				"\(ProjectSettings.projectName)UITests"
			]),
			runAction: .runAction(
				preActions: [
					.init(
						scriptText: preActionScriptForRun,
						target: .project(path: "", target: "\(ProjectSettings.projectName)")
					)
				],
				executable: "\(ProjectSettings.projectName)"
			)
		),
		Scheme(
			name: "\(ProjectSettings.projectName)Tests",
			shared: true,
			buildAction: .buildAction(targets: ["\(ProjectSettings.projectName)Tests"]),
			testAction: .targets(["\(ProjectSettings.projectName)Tests"]),
			runAction: .runAction(executable: "\(ProjectSettings.projectName)Tests")
		),
		Scheme(
			name: "\(ProjectSettings.projectName)UITests",
			shared: true,
			buildAction: .buildAction(targets: ["\(ProjectSettings.projectName)UITests"]),
			testAction: .targets(["\(ProjectSettings.projectName)UITests"]),
			runAction: .runAction(executable: "\(ProjectSettings.projectName)UITests")
		)
	],
	additionalFiles: [
		"\(ProjectSettings.projectName)/Environments/Version.sh"
	]
)

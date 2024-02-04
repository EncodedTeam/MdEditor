//
//  AppCoordinator.swift
//  MdEditor
//

import UIKit
import TaskManagerPackage

final class AppCoordinator: BaseCoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private let window: UIWindow?
	private let taskmanager: ITaskManager

	// MARK: - Initialization

	init(window: UIWindow?, taskManager: ITaskManager) {
		self.navigationController = UINavigationController()

		self.window = window
		self.window?.rootViewController = navigationController
		self.window?.makeKeyAndVisible()

		self.taskmanager = taskManager
	}
	
	// MARK: - Internal methods

	override func start() {
		let bundleUrl = Bundle.main.bundleURL
		let docsURL = bundleUrl.appendingPathComponent("Documents.bundle")

		runMainFLow(url: docsURL)
	}

	func runMainFLow(url: URL) {
//		let coordinator = MainCoordinator(navigationController: navigationController, taskManager: taskmanager)
		let coordinator = OpenFileCoordinator(navigationController: navigationController, url: url)
		coordinator.enterDirectoryFlow = { [weak self] url in
			self?.runMainFLow(url: url)
		}

		addDependency(coordinator)
		coordinator.start()
	}
}

//
//  MainCoordinator.swift
//  MdEditor
//

import UIKit
import TaskManagerPackage

final class MainCoordinator: BaseCoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private let taskManager: ITaskManager

	// MARK: - Initialization
	
	init(navigationController: UINavigationController, taskManager: ITaskManager) {
		self.navigationController = navigationController
		self.taskManager = taskManager
	}

	// MARK: - Internal methods

	override func start() {
#if DEBUG
		if CommandLine.skipLogin {
			runTodoListFlow()
			return
		}
#endif
//		runLoginFlow()
		runLoginTestingFlow()
	}

	func runLoginFlow() {
		let coordinator = LoginCoordinator(navigationController: navigationController)
		addDependency(coordinator)

		coordinator.finishFlow = { [weak self, weak coordinator] in
			self?.runEditorFlow()
			coordinator.map { self?.removeDependency($0) }
		}

		coordinator.start()
	}

	func runTodoListFlow() {
		let coordinator = TodoListCoordinator(navigationController: navigationController, taskManager: taskManager)
		addDependency(coordinator)
		coordinator.start()
	}

	func runEditorFlow() {
		let coordinator = EditorCoordinator(navigationController: navigationController)
		addDependency(coordinator)
		coordinator.start()
	}

	func runLoginTestingFlow() {
		let coordinator = LoginCoordinator(navigationController: navigationController)
		addDependency(coordinator)

		coordinator.finishFlow = { [weak self] in
			let bundleUrl = Bundle.main.bundleURL
			let docsURL = bundleUrl.appendingPathComponent("Documents.bundle")
			self?.runOpenFileScene(url: docsURL)
		}

		coordinator.start()
	}

	func runOpenFileScene(url: URL) {
		let coordinator = OpenFileCoordinator(navigationController: navigationController, url: url)
		addDependency(coordinator)
		coordinator.enterDirectoryFlow = { [weak self] url in
			if url.hasDirectoryPath {
				self?.runOpenFileScene(url: url)
			} else {
				self?.runDocumentScene(url: url)
			}
		}
		coordinator.start()
	}

	func runDocumentScene(url: URL) {
		let viewController = DocumentViewController()
		navigationController.pushViewController(viewController, animated: true)
	}
}

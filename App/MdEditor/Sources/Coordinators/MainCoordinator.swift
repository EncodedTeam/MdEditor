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
//		runLoginFlow() // TODO: change flow
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

	// TODO: change flow
	func runLoginTestingFlow() {
		let coordinator = LoginCoordinator(navigationController: navigationController)
		addDependency(coordinator)

		coordinator.finishFlow = { [weak self] in
			var urls: [URL] = []

			let bundleUrl = Bundle.main.resourceURL
			if let docsURL = bundleUrl?.appendingPathComponent("Documents.bundle") {
				urls.append(docsURL)
			}

			if let homeURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
				urls.append(homeURL)
			}

			self?.runFileListScene(urls: urls, firstShow: true)
		}

		coordinator.start()
	}

	func runFileListScene(urls: [URL], firstShow: Bool = false) {
		let coordinator = FileListCoordinator(
			navigationController: navigationController,
			urls: urls,
			firstShow: firstShow
		)
		addDependency(coordinator)
		coordinator.selectFile = { [weak self] url in
			if url.hasDirectoryPath {
				self?.runFileListScene(urls: [url])
			} else {
				self?.runOpenFileScene(urls: [url])
			}
		}
		coordinator.start()
	}

	func runOpenFileScene(urls: [URL]) {
		let viewController = DocumentViewController()
		navigationController.pushViewController(viewController, animated: true)
	}
}

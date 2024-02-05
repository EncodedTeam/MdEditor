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
	private let storage: IFileStorage

	// MARK: - Initialization
	
	init(navigationController: UINavigationController, taskManager: ITaskManager, storage: IFileStorage) {
		self.navigationController = navigationController
		self.taskManager = taskManager
		self.storage = storage
	}

	// MARK: - Internal methods

	override func start() {
#if DEBUG
		if CommandLine.skipLogin {
			runTodoListFlow()
			return
		}
#endif
		runLoginFlow()
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

		coordinator.openFileListScene = { [weak self] in
			var urls: [URL] = self?.storage.getDefaultUrls() ?? []
			self?.runFileListScene(urls: urls, firstShow: true)
		}
		
		coordinator.openAboutScene = { [weak self] in
			let bundleUrl = Bundle.main.resourceURL
			if let fileURL = bundleUrl?
				.appendingPathComponent(ResourceBundle.documents)
				.appendingPathComponent(ResourceBundle.about) {
				self?.runFileEditorScene(url: fileURL, editable: false)
			}
		}
		coordinator.start()
	}

	func runFileListScene(urls: [URL], firstShow: Bool = false) {
		let coordinator = FileListCoordinator(
			navigationController: navigationController,
			urls: urls,
			firstShow: firstShow,
			storage: storage
		)
		addDependency(coordinator)
		coordinator.selectFile = { [weak self] url in
			if url.hasDirectoryPath {
				self?.runFileListScene(urls: [url])
			} else {
				self?.runFileEditorScene(url: url)
			}
		}
		coordinator.start()
	}

	func runFileEditorScene(url: URL, editable: Bool = true) {
		let coordinator = FileEditorCoordinator(
			navigationController: navigationController,
			fileStorage: FileStorage(),
			url: url,
			editable: editable
		)
		addDependency(coordinator)
		coordinator.start()
	}
}

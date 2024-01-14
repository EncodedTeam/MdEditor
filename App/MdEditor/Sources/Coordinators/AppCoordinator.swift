//
//  AppCoordinator.swift
//  TodoList
//

import UIKit
import TaskManagerPackage

final class AppCoordinator: BaseCoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private let window: UIWindow?

	// MARK: - Initialization

	init(window: UIWindow?) {
		self.navigationController = UINavigationController()

		self.window = window
		self.window?.rootViewController = navigationController
		self.window?.makeKeyAndVisible()
	}
	
	// MARK: - Internal methods

	override func start() {
		runMainFLow()
	}

	func runMainFLow() {
		let coordinator = MainCoordinator(navigationController: navigationController, taskManager: buildTaskManager())
		addDependency(coordinator)
		coordinator.start()

		navigationController.isNavigationBarHidden = true
	}

	// MARK: - Private methods

	private func buildTaskManager() -> ITaskManager {
		let taskManager = TaskManager()
		let repository = TaskRepositoryStub()
		let orderedTaskManager = OrderedTaskManager(taskManager: taskManager)
		orderedTaskManager.addTasks(tasks: repository.getTasks())

		return orderedTaskManager
	}
}

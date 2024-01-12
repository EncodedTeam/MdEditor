//
//  ChartsCoordinator.swift
//  TodoList
//

import UIKit
import TaskManagerPackage

final class ChartsCoordinator: ICoordinator {
	
	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private let taskManager: TaskManager
	
	// MARK: - Initialization

	init(navigationController: UINavigationController, taskManager: TaskManager) {
		self.navigationController = navigationController
		self.taskManager = taskManager
	}

	func start() {
		showChartsScene()
	}

	private func showChartsScene() {
		let viewController = ChartsAssembler(taskManager: taskManager).assembly()
		navigationController.pushViewController(viewController, animated: true)
	}
}

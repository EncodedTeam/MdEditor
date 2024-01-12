//
//  CreateTaskAssembler.swift
//  TodoList
//
//  Created by Kirill Leonov on 05.12.2023.
//

import Foundation
import TaskManagerPackage

final class CreateTaskAssembler {

	// MARK: - Dependencies

	private let taskManager: ITaskManager

	// MARK: - Initialization
	
	/// Инициализатор сборщика модуля создания задания
	/// - Parameter taskManager: менеджер заданий
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	// MARK: - Public methods

	/// Сборка модуля создания задания
	/// - Parameter createTaskResult: замыкание оповещающие о результате создания задания
	/// - Returns: вью
	func assembly(createTaskResult: EmptyClosure?) -> CreateTaskViewController {
		let viewController = CreateTaskViewController()
		let presenter = CreateTaskPresenter(viewController: viewController, createTaskResult: createTaskResult)
		let interactor = CreateTaskInteractor(presenter: presenter, taskManager: taskManager)
		viewController.interactor = interactor

		return viewController
	}
}

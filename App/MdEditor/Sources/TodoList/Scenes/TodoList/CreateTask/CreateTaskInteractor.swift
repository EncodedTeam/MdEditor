//
//  CreateTaskInteractor.swift
//  TodoList
//
//  Created by Kirill Leonov on 05.12.2023.
//

import Foundation
import TaskManagerPackage

protocol ICreateTaskInteractor {

	/// Событие создания нового задания.
	/// - Parameter request: Запрос, описывающий введенные данные по заданию.
	func createTask(request: CreateTaskModel.Request)
}

final class CreateTaskInteractor: ICreateTaskInteractor {

	// MARK: - Dependencies

	private var presenter: ICreateTaskPresenter
	private let taskManager: ITaskManager

	// MARK: - Initialization

	init(presenter: ICreateTaskPresenter, taskManager: ITaskManager) {
		self.presenter = presenter
		self.taskManager = taskManager
	}

	// MARK: - Public methods

	func createTask(request: CreateTaskModel.Request) {
		switch request {
		case .regular(let title):
			let task = RegularTask(title: title)
			taskManager.addTask(task: task)
		case .important(let importantTask):
			let task = ImportantTask(
				title: importantTask.title,
				taskPriority: ImportantTask.TaskPriority(rawValue: importantTask.priority) ?? .high
			)
			taskManager.addTask(task: task)
		}
		presenter.taskCreated()
	}
}

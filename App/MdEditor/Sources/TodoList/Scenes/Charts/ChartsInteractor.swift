//
//  ChartsInteractor.swift
//  TodoList
//

import Foundation
import TaskManagerPackage

protocol IChartsInteractor {

	/// Событие на предоставление информации для графика заданий.
	func fetchData()
}

final class ChartsInteractor: IChartsInteractor {
	
	// MARK: - Dependencies
	
	private var presenter: IChartsPresenter
	private let taskManager: ITaskManager
	
	// MARK: - Initialization
	
	/// Инициализатор интерактора модуля с графиками заданий
	/// - Parameters:
	///   - presenter: презентер модуля с графиками заданий
	///   - taskManager: менеджер заданий
	init(presenter: IChartsPresenter, taskManager: ITaskManager) {
		self.presenter = presenter
		self.taskManager = taskManager
	}
	
	// MARK: - Public methods
	
	/// Событие на предоставление информации для графика заданий.
	func fetchData() {
		let tasks = ChartsModel.Response.Tasks(
			all: taskManager.allTasks().count,
			completed: taskManager.completedTasks().count,
			uncompleted: taskManager.uncompletedTasks().count
		)
		let responseData = ChartsModel.Response(data: tasks)
		presenter.present(response: responseData)
	}
}

//
//  ChartsAssembler.swift
//  TodoList
//

import UIKit
import TaskManagerPackage

final class ChartsAssembler {

	// MARK: - Dependencies

	private let taskManager: ITaskManager
	
	// MARK: - Initialization
	
	/// Сборка модуля с графиками заданий
	/// - Parameter taskManager: менеджер заданий
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	// MARK: - Public methods
	
	/// Сборка модуля с графиками заданий
	/// - Parameter taskManager: менеджер заданий
	func assembly() -> ChartsViewController {
		let viewController = ChartsViewController()
		let presenter = ChartsPresenter(viewController: viewController)
		let interactor = ChartsInteractor(presenter: presenter, taskManager: taskManager)
		viewController.interactor = interactor
		
		return viewController
	}
}

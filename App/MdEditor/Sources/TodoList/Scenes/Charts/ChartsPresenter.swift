//
//  ChartsPresenter.swift
//  TodoList
//

import Foundation

protocol IChartsPresenter {

	/// Отображение экрана с графиками  заданий.
	/// - Parameter response: Подготовленные к отображению данные.
	func present(response: ChartsModel.Response)
}

final class ChartsPresenter: IChartsPresenter {
	
	// MARK: - Dependencies
	
	private weak var viewController: IChartsViewController?
	
	// MARK: - Initialization
	
	/// Инициализатор презентера модуля с графиками заданий
	/// - Parameter viewController: вью
	init(viewController: IChartsViewController?) {
		self.viewController = viewController
	}
	
	// MARK: - Public methods
	
	/// Отображение экрана с графиками  заданий.
	/// - Parameter response: Подготовленные к отображению данные.
	func present(response: ChartsModel.Response) {
		let percent: Float = 100.0
		let completed: Float = (percent * Float(response.data.completed)) / Float(response.data.all)
		let uncompleted: Float = (percent * Float(response.data.uncompleted)) / Float(response.data.all)

		let chartSegments: [ChartsModel.ViewModel.Segment] = [
			.completed(
				ChartsModel.ViewModel.ChartSegment(
					title: String(format: "Завершенные: %.0f%%", completed),
					value: completed
				)
			),
			.uncompleted(
				ChartsModel.ViewModel.ChartSegment(
					title: String(format: "Не завершенные: %.0f%%", uncompleted),
					value: uncompleted
				)
			)
		]

		let viewModel = ChartsModel.ViewModel(segment: chartSegments)
		viewController?.render(viewModel: viewModel)
	}
}

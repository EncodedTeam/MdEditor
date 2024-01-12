//
//  ChartsViewController.swift
//  TodoList
//

import UIKit

/// Протокол экрана графиков по заданиям.
protocol IChartsViewController: AnyObject {

	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewModel: ChartsModel.ViewModel)
}

/// Эран графиков по заданиям.
final class ChartsViewController: UIViewController {

	// MARK: - Dependencies
	
	var interactor: IChartsInteractor?
	
	// MARK: - Private properties

    private var viewModel = ChartsModel.ViewModel(segment: [])
	
	private lazy var pieChartView = PieChartView()

	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		
		return tableView
	}()
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()

		setupUI()
		layout()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		interactor?.fetchData()
	}
}

// MARK: - UITableViewDelegate && UITableViewDataSource

extension ChartsViewController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.segment.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		configureCell(cell, with: viewModel.segment[indexPath.row])

		return cell
	}
}

// MARK: - IChartsViewController

extension ChartsViewController: IChartsViewController {

	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewModel: ChartsModel.ViewModel) {
		self.viewModel = viewModel
		
		tableView.reloadData()
		pieChartView.segments.removeAll()
		viewModel.segment.forEach { chartSegment in
			pieChartView.segments.append(
				Segment(
					color: chartSegment.getColor(),
					value: CGFloat(chartSegment.getChartSegment().value)
				)
			)
		}
	}
}

// MARK: - Setup UI

private extension ChartsViewController {

	func setupUI() {
		view.backgroundColor = .white
		title = "Статистика"
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		navigationController?.navigationBar.prefersLargeTitles = true

		view.addSubview(pieChartView)
		view.addSubview(tableView)
	}
	
	func configureCell(_ cell: UITableViewCell, with segment: ChartsModel.ViewModel.Segment) {
		var contentConfiguration = cell.defaultContentConfiguration()
		cell.selectionStyle = .none

		let colorText = [NSAttributedString.Key.foregroundColor: segment.getColor()]
		let taskText = NSMutableAttributedString(string: segment.getChartSegment().title, attributes: colorText)
		contentConfiguration.attributedText = taskText

		cell.contentConfiguration = contentConfiguration
	}
}

// MARK: - Layout UI

private extension ChartsViewController {
	
	func layout() {
		NSLayoutConstraint.activate(
			[
				pieChartView.topAnchor.constraint(equalTo: view.topAnchor, constant: Sizes.topInset),
				pieChartView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
				pieChartView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
				pieChartView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),

				tableView.topAnchor.constraint(equalTo: pieChartView.bottomAnchor, constant: Sizes.Padding.normal),
				tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
				tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
				tableView.heightAnchor.constraint(equalTo: view.widthAnchor)
			]
		)
	}
}

// MARK: - Prism for ChartsModel.ViewModel.Segment

extension ChartsModel.ViewModel.Segment {
	func getColor() -> UIColor {
		switch self {
		case .completed:
			return .systemMint
		case .uncompleted:
			return .systemRed
		}
	}

	func getChartSegment() -> ChartsModel.ViewModel.ChartSegment {
		switch self {
		case .completed(let value):
			return value
		case .uncompleted(let value):
			return value
		}
	}
}

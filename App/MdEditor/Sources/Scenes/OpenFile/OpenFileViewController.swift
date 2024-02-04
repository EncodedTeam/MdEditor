//
//  OpenFileViewController.swift
//  MdEditor
//
//  Created by Aksilont on 31.01.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import UIKit

/// Протокол экрана открытия файла
protocol IOpenFileViewController: AnyObject {
	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewModel: OpenFileModel.ViewModel)
}

final class OpenFileViewController: UIViewController {
	// MARK: - Dependencies
	var interactor: IOpenFileInteractor?

	// MARK: - Private properties
	private lazy var tableView: UITableView = makeTableView()
	private var viewModel = OpenFileModel.ViewModel(data: [])
	private let url: URL

	// MARK: - Initiazlization
	init(url: URL) {
		self.url = url
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		interactor?.fetchData(url: url)
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layout()
	}
}

private extension OpenFileViewController {
	func getFileForIndex(_ index: Int) -> OpenFileModel.FileViewModel {
		viewModel.data[index]
	}
}

// MARK: - UITableViewDelegate
extension OpenFileViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedFileURL = getFileForIndex(indexPath.row).url
		let request = OpenFileModel.Request(url: selectedFileURL)
		interactor?.didFileSelected(request: request)
	}
}

// MARK: - UITableViewDataSource
extension OpenFileViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.data.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: FileItemTableViewCell.cellIdentifier,
			for: indexPath
		) as? FileItemTableViewCell else {
			return UITableViewCell()
		}
		cell.selectionStyle = .none

		// Accessibility: Identifier
		cell.accessibilityIdentifier = AccessibilityIdentifier.OpenFile.cell(
			section: indexPath.section,
			row: indexPath.row
		).description

		let fileViewModel = getFileForIndex(indexPath.row)

		cell.configure(with: fileViewModel)

		return cell
	}
}

// MARK: - Setup UI
private extension OpenFileViewController {
	func makeTableView() -> UITableView {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}

	/// Настройка UI экрана
	func setupUI() {
		view.backgroundColor = Theme.backgroundColor
		title = url.lastPathComponent
		navigationItem.setHidesBackButton(false, animated: true)
		navigationController?.navigationBar.prefersLargeTitles = false

		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(FileItemTableViewCell.self, forCellReuseIdentifier: FileItemTableViewCell.cellIdentifier)

		// Accessibility: Identifier
		tableView.accessibilityIdentifier = AccessibilityIdentifier.OpenFile.tableView.description

		view.addSubview(tableView)
	}
}

// MARK: - Layout UI
private extension OpenFileViewController {
	func layout() {
		let newConstraints = [
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		]
		NSLayoutConstraint.activate(newConstraints)
	}
}

// MARK: - IOpenFileViewController
extension OpenFileViewController: IOpenFileViewController {
	func render(viewModel: OpenFileModel.ViewModel) {
		self.viewModel = viewModel
		tableView.reloadData()
	}
}

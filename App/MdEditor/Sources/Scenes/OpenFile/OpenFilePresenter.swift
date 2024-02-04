//
//  OpenFilePresenter.swift
//  MdEditor
//
//  Created by Aksilont on 31.01.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

protocol IOpenFilePresenter {
	/// Отображение экрана со списком заданий.
	/// - Parameter response: Подготовленные к отображению данные.
	func present(response: OpenFileModel.Response)

	func didFileSelected(response: URL)
}

typealias OpenFileClosure = (URL) -> Void

final class OpenFilePresenter: IOpenFilePresenter {
	// MARK: - Dependencies
	private weak var viewController: IOpenFileViewController?
	private var openFileClosure: OpenFileClosure?

	// MARK: - Initialization
	init(viewController: IOpenFileViewController, openFileClosure: OpenFileClosure?) {
		self.viewController = viewController
		self.openFileClosure = openFileClosure
	}

	// MARK: - Public methods
	func present(response: OpenFileModel.Response) {
		let viewModel = OpenFileModel.ViewModel(data: response.data)
		viewController?.render(viewModel: viewModel)
	}

	func didFileSelected(response: URL) {
		openFileClosure?(response)
	}
}

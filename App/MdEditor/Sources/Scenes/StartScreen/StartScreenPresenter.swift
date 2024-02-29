//
//  StartScreenPresenter.swift
//  MdEditor
//
//  Created by Константин Натаров on 01.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

protocol IStartScreenPresenter {
	func present(response: StartScreenModel.Response)
}

final class StartScreenPresenter: IStartScreenPresenter {
	// MARK: - Dependencies
	private weak var viewController: IStartScreenViewController?

	// MARK: - Initialization
	init(viewController: IStartScreenViewController?) {
		self.viewController = viewController
	}

	// MARK: - Public methods
	func present(response: StartScreenModel.Response) {
		var docs = response.docs
		if docs.isEmpty {
			docs.append(StartScreenModel.Document(fileName: "", content: "", stub: true))
		}
		let viewModel = StartScreenModel.ViewModel(documents: docs)

		viewController?.render(with: viewModel)
	}
}

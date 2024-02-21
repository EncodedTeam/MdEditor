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
		let docs = response.docs
		let viewModel = StartScreenModel.ViewModel(documents: docs)

		viewController?.render(with: viewModel)
	}
}

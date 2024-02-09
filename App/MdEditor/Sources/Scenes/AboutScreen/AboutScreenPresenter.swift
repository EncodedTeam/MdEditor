//
//  AboutScreenPresenter.swift
//  MdEditor
//
//  Created by Aleksey Efimov on 09.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

protocol IAboutScreenPresenter {
	func present(responce: AboutScreenModel.Response)
}

final class AboutScreenPresenter: IAboutScreenPresenter {
	
	// MARK: - Dependencies
	
	private weak var viewController: IAboutScreenViewController?
	
	// MARK: - Initialization
	
	init(viewController: IAboutScreenViewController?) {
		self.viewController = viewController
	}
	
	// MARK: - Public methods
	
	func present(responce: AboutScreenModel.Response) {
		let title = responce.title
		let fileData = responce.fileData
		viewController?.render(viewModel: AboutScreenModel.ViewModel(
			title: title,
			fileData: fileData
		))
	}
}

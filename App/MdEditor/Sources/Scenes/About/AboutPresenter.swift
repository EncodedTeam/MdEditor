//
//  AboutPresenter.swift
//  MdEditor
//
//  Created by Aleksey Efimov on 03.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

protocol IAboutPresenter {
	func present(responce: AboutModel.Response)
}

final class AboutPresenter: IAboutPresenter {
	
	// MARK: - Dependencies
	
	private weak var viewController: IAboutViewController?
	
	// MARK: - Initialization
	
	init(viewController: IAboutViewController?) {
		self.viewController = viewController
	}
	
	// MARK: - Public methods
	
	func present(responce: AboutModel.Response) {
	}
}

//
//  StartScreenPresenter.swift
//  MdEditor
//
//  Created by Константин Натаров on 01.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

protocol IStartScreenPresenter {

}

final class StartScreenPresenter: IStartScreenPresenter {
	// MARK: - Public properties

	// MARK: - Dependencies

	private weak var viewController: IStartScreenViewController?

	// MARK: - Private properties

	// MARK: - Initialization

	init(viewController: IStartScreenViewController?) {
		self.viewController = viewController
	}

	// MARK: - Public methods

	// MARK: - Private methods

}

//
//  StartScreenInteractor.swift
//  MdEditor
//
//  Created by Константин Натаров on 01.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

protocol IStartScreenInteractor {

}

final class StartScreenInteractor: IStartScreenInteractor {
	// MARK: - Public properties
	// MARK: - Dependencies

	private var presenter: IStartScreenPresenter?

	// MARK: - Private properties
	// MARK: - Initialization

	init(presenter: IStartScreenPresenter?) {
		self.presenter = presenter
	}

	// MARK: - Public methods
	// MARK: - Private methods
}

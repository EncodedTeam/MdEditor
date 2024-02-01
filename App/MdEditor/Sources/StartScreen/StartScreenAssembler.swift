//
//  StartScreenAssembler.swift
//  MdEditor
//
//  Created by Константин Натаров on 01.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

final class StartScreenAssembler {

	func assembly() -> StartScreenViewController {
		let viewController = StartScreenViewController()
		let presenter = StartScreenPresenter(viewController: viewController)
		let interactor = StartScreenInteractor(presenter: presenter)

		viewController.interactor = interactor

		return viewController
	}
}

//
//  AboutAssembler.swift
//  MdEditor
//
//  Created by Aleksey Efimov on 03.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import UIKit

final class AboutAssembler {

	func assembly() -> AboutViewController {
		let viewController = AboutViewController()
		let presenter = AboutPresenter(viewController: viewController)
		let interactor = AboutInteractor(presenter: presenter)
		viewController.interactor = interactor
		
		return viewController
	}
}

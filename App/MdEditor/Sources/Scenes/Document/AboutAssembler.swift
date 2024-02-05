//
//  AboutAssembler.swift
//  MdEditor
//
//  Created by Aleksey Efimov on 03.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import UIKit

final class AboutAssembler {

	func assembly(fileStorage: IFileStorage, url: URL, editable: Bool) -> AboutViewController {
		let viewController = AboutViewController(editable: editable)
		let presenter = AboutPresenter(viewController: viewController)
		let interactor = AboutInteractor(presenter: presenter, fileStorage: fileStorage, url: url)
		viewController.interactor = interactor
		
		return viewController
	}
}

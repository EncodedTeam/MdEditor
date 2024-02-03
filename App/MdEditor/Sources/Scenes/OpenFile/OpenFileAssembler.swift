//
//  OpenFileAssembler.swift
//  MdEditor
//
//  Created by Aksilont on 31.01.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import UIKit

final class OpenFileAssembler {
	/// Сборка модуля открытия файла
	/// - Returns: `OpenFileViewController`
	func assembly() -> OpenFileViewController {
		let viewController = OpenFileViewController()
		let presenter = OpenFilePresenter(viewController: viewController)
		let worker = OpenFileWorker()
		let interactor = OpenFileInteractor(presenter: presenter, worker: worker)
		
		viewController.interactor = interactor

		return viewController
	}
}

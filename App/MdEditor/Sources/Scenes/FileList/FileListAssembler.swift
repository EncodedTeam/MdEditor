//
//  FileListAssembler.swift
//  MdEditor
//
//  Created by Aksilont on 31.01.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import UIKit

final class FileListAssembler {
	/// Сборка модуля открытия файла
	/// - Returns: `OpenFileViewController`
	func assembly(urls: [URL], firstShow: Bool, openFileClosure: FileListClosure?) -> FileListViewController {
		let viewController = FileListViewController(urls: urls, firstShow: firstShow)
		let presenter = FileListPresenter(viewController: viewController, openFileClosure: openFileClosure)
		let interactor = FileListInteractor(presenter: presenter)
		
		viewController.interactor = interactor

		return viewController
	}
}

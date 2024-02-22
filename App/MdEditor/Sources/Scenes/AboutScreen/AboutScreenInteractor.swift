//
//  AboutScreenInteractor.swift
//  MdEditor
//
//  Created by Aleksey Efimov on 09.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

protocol IAboutScreenInteractor: AnyObject {
	/// Событие на предоставление данных из файла about.
	func fetchData()
}

final class AboutScreenInteractor: IAboutScreenInteractor {
	// MARK: - Dependencies
	private var presenter: IAboutScreenPresenter?
	private var fileStorage: IStorageService

	// MARK: - Initialization
	init(presenter: IAboutScreenPresenter, fileStorage: IStorageService) {
		self.presenter = presenter
		self.fileStorage = fileStorage
	}
	
	// MARK: - Public methods
	func fetchData() {
		let url = ResourcesBundle.aboutFile
		Task {
			guard let file = try? await fileStorage.getEntity(from: url, with: []) else { return }
			let result = await fileStorage.loadFile(file)
			await updateUI(fileData: result)
		}
	}
	
	@MainActor
	func updateUI(fileData: String) {
		presenter?.present(responce: AboutScreenModel.Response(fileData: fileData))
	}
}

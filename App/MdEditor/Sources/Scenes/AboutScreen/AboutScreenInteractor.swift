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
	private var fileStorage: IFileStorage?
	
	// MARK: - Private properties
	
	private var url: URL
	
	// MARK: - Initialization
	
	init(presenter: IAboutScreenPresenter, fileStorage: IFileStorage, url: URL) {
		self.presenter = presenter
		self.fileStorage = fileStorage
		self.url = url
	}
	
	// MARK: - Public methods
	
	func fetchData() {
		let title = url.lastPathComponent
		let fileData = fileStorage?.loadFileBody(url: url) ?? ""
		presenter?.present(responce: AboutScreenModel.Response(
			title: title,
			fileData: fileData
		))
	}
}

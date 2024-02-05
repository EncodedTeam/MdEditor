//
//  AboutInteractor.swift
//  MdEditor
//
//  Created by Aleksey Efimov on 03.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

protocol IAboutInteractor: AnyObject {
	/// Событие на предоставление данных из файла about.
	func fetchData()
}

final class AboutInteractor: IAboutInteractor {
	
	// MARK: - Dependencies
	
	private var presenter: IAboutPresenter?
	private var fileStorage: IFileStorage?
	
	// MARK: - Private properties
	
	private var url: URL
	
	// MARK: - Initialization
	
	init(presenter: IAboutPresenter, fileStorage: IFileStorage, url: URL) {
		self.presenter = presenter
		self.fileStorage = fileStorage
		self.url = url
	}
	
	// MARK: - Public methods
	
	func fetchData() {
		let title = url.lastPathComponent
		let fileData = fileStorage?.loadFileBody(url: url) ?? "" // TODO: сделать алерт при ошибке
		presenter?.present(responce: AboutModel.Response(
			title: title,
			fileData: fileData
		))
	}
}

//
//  AboutInteractor.swift
//  MdEditor
//
//  Created by Aleksey Efimov on 03.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

protocol IFileEditorInteractor: AnyObject {
	/// Событие на предоставление данных из файла.
	func fetchData()
}

final class FileEditorInteractor: IFileEditorInteractor {
	// MARK: - Dependencies
	private var presenter: IFileEditorPresenter?
	private var storage: IStorageService

	// MARK: - Private properties
	private var file: FileSystemEntity

	// MARK: - Initialization
	init(presenter: IFileEditorPresenter, storage: IStorageService, file: FileSystemEntity) {
		self.presenter = presenter
		self.storage = storage
		self.file = file
	}

	// MARK: - Public methods
	func fetchData() {
		let title = file.name
		updateTitle(title: title)
		Task {
			let title = file.name
			let result = file.loadFileBody()
			await RecentFileManager(key: UserDefaults.Keys.recentFilesKey.rawValue).addToRecentFiles(file)
			await updateUI(with: title, fileData: result)
		}
	}
	
	private func updateTitle(title: String) {
		presenter?.presentTitle(responce: FileEditorModel.Response(title: title, fileData: ""))
	}

	@MainActor
	func updateUI(with title: String, fileData: String) {
		let response = FileEditorModel.Response(
			title: title,
			fileData: fileData
		)
		presenter?.present(responce: response)
	}
}

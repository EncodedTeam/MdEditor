//
//  FileListInteractor.swift
//  MdEditor
//
//  Created by Aksilont on 31.01.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

protocol IFileListInteractor {
	/// Событие на предоставление информации для списка файлов.
	/// - Parameter url: Адрес конректного файла
	func fetchData(url: URL)
	
	/// Событие на предоставление стартовых директорий
	/// - Parameter urls: Массив адресов стартовых директорий
	func fetchStartData(urls: [URL])

	/// Событие, что файл бы выбран
	/// - Parameter request: Запрос, содержащий информацию о выбранном файле.
	func didFileSelected(request: FileListModel.Request)
}

final class FileListInteractor: IFileListInteractor {
	// MARK: - Dependencies
	private var presenter: IFileListPresenter

	// MARK: - Initialization
	init(presenter: IFileListPresenter) {
		self.presenter = presenter
	}

	// MARK: - Public methods
	func fetchStartData(urls: [URL]) {
		var responseData = [FileListModel.FileViewModel]()

		var files: [File]
		let storage = FileStorage() // TODO: перенести зависимость в инит
		do {
			files = try storage.getFile(items: urls)
		} catch {
			fatalError("No files")
		}

		let responseFiles = files.map { file in
			FileListModel.FileViewModel(
				url: file.url,
				name: file.name,
				isDir: file.isDir,
				description: file.getFormattedAttributes()
			)
		}

		responseData.append(contentsOf: responseFiles)

		let response = FileListModel.Response(data: responseData)
		presenter.present(response: response)
	}

	func fetchData(url: URL) {
		var responseData = [FileListModel.FileViewModel]()

		var files: [File]
		let storage = FileStorage()
		do {
			files = try storage.scan(url: url)
		} catch {
			fatalError("No files")
		}

		let responseFiles = files.map { file in
			FileListModel.FileViewModel(
				url: file.url,
				name: file.name,
				isDir: file.isDir,
				description: file.getFormattedAttributes()
			)
		}
		responseData.append(contentsOf: responseFiles)

		let response = FileListModel.Response(data: responseData)
		presenter.present(response: response)
	}

	func didFileSelected(request: FileListModel.Request) {
		presenter.didFileSelected(response: request.url)
	}
}

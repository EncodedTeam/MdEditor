//
//  OpenFileInteractor.swift
//  MdEditor
//
//  Created by Aksilont on 31.01.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

protocol IOpenFileInteractor {
	/// Событие на предоставление информации для списка файлов.
	func fetchData(url: URL)

	/// Событие, что файл бы выбран
	/// - Parameter request: Запрос, содержащий информацию о выбранном файле.
	func didFileSelected(request: OpenFileModel.Request)
}

final class OpenFileInteractor: IOpenFileInteractor {
	// MARK: - Dependencies
	private var presenter: IOpenFilePresenter
	private var worker: IOpenFileWorker

	// MARK: - Initialization
	init(presenter: IOpenFilePresenter, worker: IOpenFileWorker) {
		self.presenter = presenter
		self.worker = worker
	}

	// MARK: - Public methods
	func fetchData(url: URL) {
		var responseData = [OpenFileModel.FileViewModel]()

		var files: [File]
		let storage = FileStorage()
		do {
			files = try storage.scan(url: url)
		} catch {
			fatalError("No files")
		}

		let responseFiles = files.map { file in
			OpenFileModel.FileViewModel(
				url: file.url,
				name: file.name,
				isDir: file.isDir,
				description: file.getFormattedAttributes()
			)
		}
		responseData.append(contentsOf: responseFiles)

		let response = OpenFileModel.Response(data: responseData)
		presenter.present(response: response)
	}

	func didFileSelected(request: OpenFileModel.Request) {
	}
}

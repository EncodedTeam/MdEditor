//
//  OpenFileInteractor.swift
//  MdEditor
//
//  Created by Aksilont on 31.01.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

protocol IOpenFileInteractor {
	/// Открывает выбранный файл
	/// - Parameter request: `OpenFileModel.Request`
	func openFile(request: OpenFileModel.Request)
}

final class OpenFileInteractor: IOpenFileInteractor {
	// MARK: - Dependencies
	private var presenter: IOpenFilePresenter?
	private var worker: IOpenFileWorker

	// MARK: - Initialization
	init(presenter: IOpenFilePresenter, worker: IOpenFileWorker) {
		self.presenter = presenter
		self.worker = worker
	}

	// MARK: - Public methods
	func openFile(request: OpenFileModel.Request) {
	}
}

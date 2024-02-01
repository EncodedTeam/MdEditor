//
//  StartScreenInteractor.swift
//  MdEditor
//
//  Created by Константин Натаров on 01.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

protocol IStartScreenInteractor {
	func fetchData()
}

final class StartScreenInteractor: IStartScreenInteractor {
	// MARK: - Public properties
	// MARK: - Dependencies

	private var presenter: IStartScreenPresenter?
	private var docsRepository: IDocsRepository

	// MARK: - Private properties
	// MARK: - Initialization

	init(presenter: IStartScreenPresenter?, docsRepository: IDocsRepository) {
		self.presenter = presenter
		self.docsRepository = docsRepository
	}

	// MARK: - Public methods

	func fetchData() {
		let docsFromRepository = docsRepository.getDocs()
		print(docsFromRepository.first?.fileName)
		let documents = docsFromRepository.map { document in
			StartScreenModel.Document(
				fileName: document.fileName,
				preview: ImageData(data: document.preview?.pngData())
			)
		}
		let response = StartScreenModel.Response(docs: documents)
		presenter?.present(response: response)
	}

	// MARK: - Private methods
}

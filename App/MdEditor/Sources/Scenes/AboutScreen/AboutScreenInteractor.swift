//
//  AboutScreenInteractor.swift
//  MdEditor
//
//  Created by Aleksey Efimov on 09.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation
import MarkdownPackage

protocol IAboutScreenInteractor: AnyObject {
	
	/// Событие на предоставление данных из файла about.
	func fetchData()
}

final class AboutScreenInteractor: IAboutScreenInteractor {
	
	// MARK: - Dependencies
	
	private var presenter: IAboutScreenPresenter?
	private var fileStorage: IStorageService?
	
	// MARK: - Private properties
	
	private var url: URL
	private var attributedText = NSMutableAttributedString(string: "")
	
	// MARK: - Initialization
	
	init(presenter: IAboutScreenPresenter, fileStorage: IStorageService, url: URL) {
		self.presenter = presenter
		self.fileStorage = fileStorage
		self.url = url
	}
	
	// MARK: - Public methods
	
	func fetchData() {
		Task {
			let result = await fileStorage?.loadFileBody(url: url) ?? ""
			await updateUI(fileData: result)
		}
	}
	
	@MainActor
	func updateUI(fileData: String) {
		let tokens = Lexer().tokenize(fileData)
		let document = Parser().parse(tokens: tokens)
		
		attributedText.append(document.accept(AttibuteTextVisitor()))
		
		presenter?.present(responce: AboutScreenModel.Response(fileData: attributedText))
	}
}

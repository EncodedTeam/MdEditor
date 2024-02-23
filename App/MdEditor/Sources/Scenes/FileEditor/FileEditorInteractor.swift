//
//  AboutInteractor.swift
//  MdEditor
//
//  Created by Aleksey Efimov on 03.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation
import MarkdownPackage

protocol IFileEditorInteractor: AnyObject {
	/// Событие на предоставление данных из файла.
	func fetchData()
}

final class FileEditorInteractor: IFileEditorInteractor {
	
	// MARK: - Dependencies
	
	private var presenter: IFileEditorPresenter?
	private var fileStorage: IStorageService?
	
	// MARK: - Private properties
	
	private var url: URL
	
	// MARK: - Initialization
	
	init(presenter: IFileEditorPresenter, fileStorage: IStorageService, url: URL) {
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
			let result = await storage?.loadFileBody(url: file.url) ?? ""
			await updateUI(with: title, fileData: result)
		}
	}
	
	private func updateTitle(title: String) {
		presenter?.presentTitle(responce: FileEditorModel.Response(title: title, fileData: NSMutableAttributedString()))
	}
	
	@MainActor
	func updateUI(with title: String, fileData: String) {
		
		let tokens = Lexer().tokenize(fileData)
		let document = Parser().parse(tokens: tokens)
		
		let attributedText = document.accept(AttibuteTextVisitor())
		let stringsAttributedText = NSMutableAttributedString()
		for oneString in attributedText {
			
			stringsAttributedText.append(oneString)
			
			presenter?.present(responce: FileEditorModel.Response(
				title: title,
				fileData: stringsAttributedText
			))
		}
	}
}

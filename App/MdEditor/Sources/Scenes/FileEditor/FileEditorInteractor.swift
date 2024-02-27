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
	private var storage: IStorageService?
	
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
		
		let visitor = AttibutedTextVisitor()
		let attributedText = document.accept(visitor)

		presenter?.present(responce: FileEditorModel.Response(title: title, fileData: attributedText.joined()))
	}
}

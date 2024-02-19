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
		parseText(from: document)
		
		presenter?.present(responce: AboutScreenModel.Response(fileData: attributedText))
	}
}

private extension AboutScreenInteractor {
	func parseText(from document: Document) {
		attributedText = NSMutableAttributedString(string: "")
		let textNode = getTextNode(node: document.children.first ?? BaseNode())
		attributedText.append(textNode)
	}
	
	func getTextNode(node: INode) -> NSAttributedString {
		let nodeText = node.accept(TextResultVisitor())
		
		for child in node.children {
			getTextNode(node: child)
		}
		return nodeText
	}
}

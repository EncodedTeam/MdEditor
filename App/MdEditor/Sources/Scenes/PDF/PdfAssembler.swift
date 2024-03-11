//
//  PdfAssembler.swift
//  MdEditor
//
//  Created by Aksilont on 11.03.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import UIKit
import MarkdownPackage

final class PdfAssembler {
	func assembly(text: String, author: String, title: String) -> UIViewController {
		let data = MarkdownToPdfConverter().convert(markdownText: text, pdfAuthor: author, pdfTitle: title)
		
		let viewController = PdfViewController(data: data)
		return viewController
	}
}

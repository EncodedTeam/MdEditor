//
//  Lexer.swift
//	MarkdownPackage
//
//  Created by Aksilont on 15.02.2024.
//

import Foundation

protocol ILexer {
	func tokenize(_ input: String) -> [Token]
}

final class Lexer: ILexer {
	func tokenize(_ input: String) -> [Token] {
		[]
	}
}

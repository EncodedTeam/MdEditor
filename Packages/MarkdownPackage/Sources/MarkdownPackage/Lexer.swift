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

public final class Lexer: ILexer {
	public init() { }
	
	public func tokenize(_ input: String) -> [Token] {
		let lines = input.components(separatedBy: .newlines)
		var tokens: [Token?] = []

		for line in lines {
			tokens.append(parseLineBreak(rawText: line))
			tokens.append(parseHeader(rawText: line))
			tokens.append(parseBlockquote(rawText: line))
			tokens.append(parseParagraph(rawText: line))
		}

		return tokens.compactMap { $0 }
	}
}

private extension Lexer {
	func parseLineBreak(rawText: String) -> Token? {
		guard rawText.isEmpty else { return nil }
		return .lineBreak
	}

	func parseHeader(rawText: String) -> Token? {
		let regex = /^(?<headerLevel>#{1,6})\s+(?<headerText>.+)/

		if let match = rawText.wholeMatch(of: regex) {
			let headerLevel = String(match.headerLevel).count
			let headerText = parseString(String(match.headerText))
			return .header(level: headerLevel, text: headerText)
		}

		return nil
	}
	
	func parseParagraph(rawText: String) -> Token? {
		let regex = /^([^#>].*)/

		if let match = rawText.wholeMatch(of: regex) {
			let paragraphText = parseString(String(match.output.1))
			return .paragraph(text: paragraphText)
		}

		return nil
	}

	func parseBlockquote(rawText: String) -> Token? {
		let regex = /^(?<blockquoteLevel>>{1,6})\s+(?<blockquoteText>.+)/

		if let match = rawText.wholeMatch(of: regex) {
			let blockquoteLevel = String(match.blockquoteLevel).count
			let blockquoteText = parseString(String(match.blockquoteText))
			return .blockQuote(level: blockquoteLevel, text: blockquoteText)
		}

		return nil
	}

	func parseString(_ rawText: String) -> Text {
		Text(text: [.normal(text: rawText)])
	}


}

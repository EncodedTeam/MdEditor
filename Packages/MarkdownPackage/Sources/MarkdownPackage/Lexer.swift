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
		if #available(iOS 16, macOS 13, *) {
			let regex = /^(?<level>#{1,6})\s+(?<text>.+)/

			if let match = rawText.wholeMatch(of: regex) {
				let headerLevel = String(match.level).count
				let headerText = parseString(String(match.text))
				return .header(level: headerLevel, text: headerText)
			}
		} else {
			let pattern = #"^(?<level>#{1,6})\s+(?<text>.+)"#
			if let match = try? rawText.firstMatch(pattern: pattern) {
				let rangeLevel = match.range(withName: "level")
				let rangeText = match.range(withName: "text")
				let headerLevel = rawText.substring(with: rangeLevel).count
				let headerText = parseString(rawText.substring(with: rangeText))
				return .header(level: headerLevel, text: headerText)
			}
		}
		return nil
	}
	
	func parseParagraph(rawText: String) -> Token? {
		if #available(iOS 16, macOS 13, *) {
			let regex = /^(?<text>[^#>].*)/
			if let match = rawText.wholeMatch(of: regex) {
				let paragraphText = parseString(String(match.text))
				return .paragraph(text: paragraphText)
			}
		} else {
			let pattern = #"^(?<text>[^#>].*)"#
			if let match = try? rawText.firstMatch(pattern: pattern) {
				let rangeText = match.range(withName: "text")
				let paragraphText = parseString(rawText.substring(with: rangeText))
				return .paragraph(text: paragraphText)
			}
		}

		return nil
	}

	func parseBlockquote(rawText: String) -> Token? {
		if #available(iOS 16, macOS 13, *) {
			let regex = /^(?<blockquoteLevel>>{1,6})\s+(?<blockquoteText>.+)/
			if let match = rawText.wholeMatch(of: regex) {
				let blockquoteLevel = String(match.blockquoteLevel).count
				let blockquoteText = parseString(String(match.blockquoteText))
				return .blockQuote(level: blockquoteLevel, text: blockquoteText)
			}
		} else {
			let pattern = #"^(?<level>>{1,6})\s+(?<text>.+)"#
			if let match = try? rawText.firstMatch(pattern: pattern) {
				let rangeLevel = match.range(withName: "level")
				let rangeText = match.range(withName: "text")
				let blockquoteLevel = rawText.substring(with: rangeLevel).count
				let blockquoteText = parseString(rawText.substring(with: rangeText))
				return .blockQuote(level: blockquoteLevel, text: blockquoteText)
			}
		}

		return nil
	}

	func parseString(_ rawText: String) -> Text {
		TextParser().parse(rawText: rawText)
	}
}

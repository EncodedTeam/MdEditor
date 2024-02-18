//
//  Parser.swift
//	MarkdownPackage
//
//  Created by Aksilont on 18.02.2024.
//

import Foundation

public final class Parser {
	func parse(tokens: [Token]) -> Document {
		var tempTokens = tokens
		var result: [INode] = []

		while !tempTokens.isEmpty {
			var nodes: [INode?] = []
			nodes.append(parseHeader(tokens: &tempTokens))
			nodes.append(parseBlockquote(tokens: &tempTokens))
			nodes.append(parseParagraph(tokens: &tempTokens))
//			nodes.append(parseImage(tokens: &tempTokens))
			nodes.append(parseLineBreak(tokens: &tempTokens))
			nodes.append(parseCodeBlock(tokens: &tempTokens))

			/// Очистим массив распарсенных нодов от nil
			let parsedNodes = nodes.compactMap { $0 }

			/// Если массив распарсенных нодов пустой, значит мы не смогли распарсить токен
			/// и его нужно удалить, чтобы перейти к следующему и исключить бесконечный цикл
			if parsedNodes.isEmpty, !tempTokens.isEmpty {
				tempTokens.removeFirst()
			} else {
				result.append(contentsOf: parsedNodes)
			}
		}

		return Document(result)
	}
}

private extension Parser {
	func parseHeader(tokens: inout [Token]) -> HeaderNode? {
		guard let token = tokens.first else { return nil }
		
		if case let .header(level, text) = token {
			tokens.removeFirst()
			return HeaderNode(level: level, children: parseText(text))
		}

		return nil
	}

	func parseBlockquote(tokens: inout [Token]) -> BlockquoteNode? {
		guard let token = tokens.first else { return nil }
		
		if case let .blockQuote(level, text) = token {
			tokens.removeFirst()
			return BlockquoteNode(level: level, children: parseText(text))
		}

		return nil
	}

	func parseParagraph(tokens: inout [Token]) -> ParagraphNode? {
		var textNodes: [INode] = []

		while !tokens.isEmpty {
			guard let token = tokens.first else { return nil }

			if case let .textLine(text) = token {
				tokens.removeFirst()
				textNodes.append(contentsOf: parseText(text))
			} else {
				break
			}
		}

		if !textNodes.isEmpty {
			return ParagraphNode(textNodes)
		}

		return nil
	}

	func parseImage(tokens: inout [Token]) -> ImageNode? {
		guard let token = tokens.first else { return nil }

		return nil
	}

	func parseLineBreak(tokens: inout [Token]) -> LineBreakNode? {
		guard let token = tokens.first else { return nil }
		
		if case .lineBreak = token {
			tokens.removeFirst()
			return LineBreakNode()
		}

		return nil
	}

	func parseCodeBlock(tokens: inout [Token]) -> CodeBlockNode? {
		var inlineCodeItems: [INode] = []
		var startBlock = true
		var levelNode = 0
		var languageNode = ""

		while !tokens.isEmpty {
			guard let token = tokens.first else { return nil }

			if case let .codeBlockMarker(level: level, lang: lang) = token {
				tokens.removeFirst()
				if startBlock {
					levelNode = level
					languageNode = lang
					startBlock = false
				}
			} else if case let .codeLine(text: code) = token {
				tokens.removeFirst()
				inlineCodeItems.append(InlineCodeTextNode(code: code))
			} else {
				break
			}
		}

		if !inlineCodeItems.isEmpty {
			return CodeBlockNode(level: levelNode, language: languageNode, children: inlineCodeItems)
		}

		return nil
	}

	func parseText(_ textOfParts: Text) -> [INode] {
		var textNodes: [INode] = []
		textOfParts.text.forEach { part in
			switch part {
			case .normal(let text):
				textNodes.append(TextNode(text: text))
			case .bold(let text):
				textNodes.append(BoldTextNode(text: text))
			case .italic(let text):
				textNodes.append(ItalicTextNode(text: text))
			case .boldItalic(let text):
				textNodes.append(BoldItalicTextNode(text: text))
			case .inlineCode(let code):
				textNodes.append(InlineCodeTextNode(code: code))
			case .escapedChar(let char):
				textNodes.append(EscapedCharTextNode(char: char))
			}
		}
		return textNodes
	}
}

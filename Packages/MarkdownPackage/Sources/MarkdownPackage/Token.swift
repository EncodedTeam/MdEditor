//
//  Token.swift
//	MarkdownPackage
//
//  Created by Aksilont on 15.02.2024.
//

import Foundation

public enum Token {
	case header(level: Int, text: Text)
	case blockQuote(level: Int, text: Text)
	case codeBlockMarker(level: Int, lang: String)
	case codeLine(text: String)
	case bulletedListItem(level: Int, marker: String, text: Text)
	case numberedListItem(level: Int, marker: String, text: Text)
	case textLine(text: Text)
	case link(url: String, text: String)
	case image(url: String, size: Int)
	case lineBreak
	case horizontalLine(level: Int)
}

public struct Text {
	let text: [Part]

	enum Part {
		case normal(text: String)
		case bold(text: String)
		case italic(text: String)
		case boldItalic(text: String)
		case inlineCode(text: String)
		case escapedChar(char: String)
	}
}

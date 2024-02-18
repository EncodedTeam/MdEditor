//
//  Nodes.swift
//	MarkdownPackage
//
//  Created by Aksilont on 18.02.2024.
//

import Foundation

public protocol INode {
	var children: [INode] { get }
}

public class BaseNode: INode {
	public private(set) var children: [INode]

	public init(_ children: [INode] = []) {
		self.children = children
	}
}

// MARK: - Main Root Node - Document
public final class Document: BaseNode {
}

// MARK: - Header
public final class HeaderNode: BaseNode {
	let level: Int

	init(level: Int, children: [INode] = []) {
		self.level = level
		super.init(children)
	}
}

// MARK: - Block Quote
public final class BlockquoteNode: BaseNode {
	let level: Int

	init(level: Int, children: [INode] = []) {
		self.level = level
		super.init(children)
	}
}

// MARK: - Paragraph
public final class ParagraphNode: BaseNode {
}

public final class TextNode: BaseNode {
	let text: String

	public init(text: String) {
		self.text = text
	}
}

public final class BoldTextNode: BaseNode {
	let text: String

	public init(text: String) {
		self.text = text
	}
}

public final class ItalicTextNode: BaseNode {
	let text: String

	public init(text: String) {
		self.text = text
	}
}

public final class BoldItalicTextNode: BaseNode {
	let text: String

	public init(text: String) {
		self.text = text
	}
}

public final class InlineCodeTextNode: BaseNode {
	let code: String

	public init(code: String) {
		self.code = code
	}
}

public final class EscapedCharTextNode: BaseNode {
	let char: String

	public init(char: String) {
		self.char = char
	}
}

// MARK: - Image
public final class ImageNode: BaseNode {
	let url: String
	let size: String

	init(url: String, size: String) {
		self.url = url
		self.size = size
	}
}

// MARK: - Line Break
public final class LineBreakNode: BaseNode {
}

// MARK: - Code Block
public final class CodeBlockNode: BaseNode {
	let level: Int
	let language: String

	init(level: Int, language: String, children: [INode] = []) {
		self.level = level
		self.language = language
		super.init(children)
	}
}

// MARK: - Bulleted List
public final class BulletedListNode: BaseNode {
	let level: Int

	init(level: Int, children: [INode] = []) {
		self.level = level
		super.init(children)
	}
}

public final class BulletedListItem: BaseNode {
	let marker: String

	init(marker: String, children: [INode]) {
		self.marker = marker
		super.init(children)
	}
}

// MARK: - Numbered List
public final class NumberedListNode: BaseNode {
	let level: Int

	init(level: Int, children: [INode] = []) {
		self.level = level
		super.init(children)
	}
}

public final class NumberedListItem: BaseNode {
	let marker: String

	init(marker: String, children: [INode]) {
		self.marker = marker
		super.init(children)
	}
}

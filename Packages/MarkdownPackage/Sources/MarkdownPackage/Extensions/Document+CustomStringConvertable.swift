//
//  File.swift
//  
//
//  Created by Aleksey Efimov on 22.02.2024.
//

import Foundation

extension Document: CustomStringConvertible {
	public var description: String {
		"\(children.map{ "\($0)" }.joined(separator: "\n"))"
	}
}

extension HeaderNode: CustomStringConvertible {
	public var description: String {
		"Header Level \(level)\n\t\(children.map{ "\t\t\($0)" }.joined(separator: " "))"
	}
}

extension ParagraphNode: CustomStringConvertible {
	public var description: String {
		"Paragraph\n\t\(children.map{ "\t\t\($0)" }.joined(separator: " "))"
	}
}

extension TextNode: CustomStringConvertible {
	public var description: String {
		"Text: \(text)"
	}
}

extension BoldTextNode: CustomStringConvertible {
	public var description: String {
		"BoldText: \(text)"
	}
}

extension ItalicTextNode: CustomStringConvertible {
	public var description: String {
		"ItalicText: \(text)"
	}
}

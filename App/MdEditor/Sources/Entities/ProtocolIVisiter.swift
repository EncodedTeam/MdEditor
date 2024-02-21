//
//  ProtocolIVisiter.swift
//  MdEditor
//
//  Created by Aleksey Efimov on 21.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation
import MarkdownPackage

// MARK: - protocol IVisitor

protocol IVisitor where Self: INode {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString
}

// MARK: - Base

extension Document: IVisitor {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString {
		return visitor.visit(self)
	}
}

// MARK: - Header

extension HeaderNode: IVisitor {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString {
		return visitor.visit(self)
	}
}

// MARK: - Block Quote

extension BlockquoteNode: IVisitor {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString {
		return visitor.visit(self)
	}
}

// MARK: - Paragraph

extension ParagraphNode: IVisitor {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString {
		return visitor.visit(self)
	}
}

extension TextNode: IVisitor {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString {
		return visitor.visit(self)
	}
}

extension BoldTextNode: IVisitor {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString {
		return visitor.visit(self)
	}
}

extension ItalicTextNode: IVisitor {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString {
		return visitor.visit(self)
	}
}

extension BoldItalicTextNode: IVisitor {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString {
		return visitor.visit(self)
	}
}

extension InlineCodeTextNode: IVisitor {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString {
		return visitor.visit(self)
	}
}

extension EscapedCharTextNode: IVisitor {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString {
		return visitor.visit(self)
	}
}

extension LinkNode: IVisitor {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString {
		return visitor.visit(self)
	}
}

extension ImageNode: IVisitor {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString {
		return visitor.visit(self)
	}
}

// MARK: - Line Break

extension LineBreakNode: IVisitor {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString {
		return visitor.visit(self)
	}
}

// MARK: - Horizontal Line

extension HorizontalLineNode: IVisitor {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString {
		return visitor.visit(self)
	}
}

// MARK: - Code Block

extension CodeBlockNode: IVisitor {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString {
		return visitor.visit(self)
	}
}

// MARK: - Bulleted List

extension BulletedListNode: IVisitor {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString {
		return visitor.visit(self)
	}
}

extension BulletedListItem: IVisitor {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString {
		return visitor.visit(self)
	}
}

// MARK: - Numbered List

extension NumberedListNode: IVisitor {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString {
		return visitor.visit(self)
	}
}

extension NumberedListItem: IVisitor {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString {
		return visitor.visit(self)
	}
}

//
//  AttributetTextVisitor.swift
//  MdEditor
//
//  Created by Aleksey Efimov on 19.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import UIKit
import MarkdownPackage

protocol IAttibuteTextVisitor {
	func visit(_ node: INode) -> NSAttributedString
	func visit(_ node: Document) -> NSAttributedString
	func visit(_ node: HeaderNode) -> NSAttributedString
	func visit(_ node: BlockquoteNode) -> NSAttributedString
	func visit(_ node: ParagraphNode) -> NSAttributedString
	func visit(_ node: TextNode) -> NSAttributedString
	func visit(_ node: BoldTextNode) -> NSAttributedString
	func visit(_ node: ItalicTextNode) -> NSAttributedString
	func visit(_ node: BoldItalicTextNode) -> NSAttributedString
	func visit(_ node: InlineCodeTextNode) -> NSAttributedString
	func visit(_ node: EscapedCharTextNode) -> NSAttributedString
	func visit(_ node: LinkNode) -> NSAttributedString
	func visit(_ node: ImageNode) -> NSAttributedString
	func visit(_ node: LineBreakNode) -> NSAttributedString
	func visit(_ node: HorizontalLineNode) -> NSAttributedString
	func visit(_ node: CodeBlockNode) -> NSAttributedString
	func visit(_ node: BulletedListNode) -> NSAttributedString
	func visit(_ node: BulletedListItem) -> NSAttributedString
	func visit(_ node: NumberedListNode) -> NSAttributedString
	func visit(_ node: NumberedListItem) -> NSAttributedString
}

class TextResultVisitor: IAttibuteTextVisitor {
	func visit(_ node: INode) -> NSAttributedString {
		let result = NSMutableAttributedString()
		return result
	}
	
	func visit(_ node: Document) -> NSAttributedString {
		let result = NSMutableAttributedString()
		return result
	}
	
	func visit(_ node: HeaderNode) -> NSAttributedString {
		let attributes: [NSAttributedString.Key: Any] = [
			.font: UIFont.boldSystemFont(ofSize: 10)
		]
		let attributedText = NSAttributedString(string: "", attributes: attributes)
		return attributedText
	}
	
	func visit(_ node: BlockquoteNode) -> NSAttributedString {
		let attributedText = NSAttributedString()
		return attributedText
	}
	
	func visit(_ node: ParagraphNode) -> NSAttributedString {
		let attributedText = NSAttributedString()
		return attributedText
	}
	
	func visit(_ node: TextNode) -> NSAttributedString {
		let attributedText = NSAttributedString(string: node.text)
		return attributedText
	}
	
	func visit(_ node: BoldTextNode) -> NSAttributedString {
		let attributes: [NSAttributedString.Key: Any] = [
			.font: UIFont.boldSystemFont(ofSize: 10)
		]
		let attributedText = NSAttributedString(string: "", attributes: attributes)
		return attributedText
	}
	
	func visit(_ node: ItalicTextNode) -> NSAttributedString {
		let attributes: [NSAttributedString.Key: Any] = [
			.font: UIFont.boldSystemFont(ofSize: 10)
		]
		let attributedText = NSAttributedString(string: "", attributes: attributes)
		return attributedText
	}
	
	func visit(_ node: BoldItalicTextNode) -> NSAttributedString {
		let attributedText = NSAttributedString()
		return attributedText
	}
	
	func visit(_ node: InlineCodeTextNode) -> NSAttributedString {
		let attributedText = NSAttributedString()
		return attributedText
	}
	
	func visit(_ node: EscapedCharTextNode) -> NSAttributedString {
		let attributedText = NSAttributedString()
		return attributedText
	}
	
	func visit(_ node: LinkNode) -> NSAttributedString {
		let attributedText = NSAttributedString()
		return attributedText
	}
	
	func visit(_ node: ImageNode) -> NSAttributedString {
		let attributedText = NSAttributedString()
		return attributedText
	}
	
	func visit(_ node: LineBreakNode) -> NSAttributedString {
		let attributedText = NSAttributedString()
		return attributedText
	}
	
	func visit(_ node: HorizontalLineNode) -> NSAttributedString {
		let attributedText = NSAttributedString()
		return attributedText
	}
	
	func visit(_ node: CodeBlockNode) -> NSAttributedString {
		let attributedText = NSAttributedString()
		return attributedText
	}
	
	func visit(_ node: BulletedListNode) -> NSAttributedString {
		let attributedText = NSAttributedString()
		return attributedText
	}
	
	func visit(_ node: BulletedListItem) -> NSAttributedString {
		let attributedText = NSAttributedString()
		return attributedText
	}
	
	func visit(_ node: NumberedListNode) -> NSAttributedString {
		let attributedText = NSAttributedString()
		return attributedText
	}
	
	func visit(_ node: NumberedListItem) -> NSAttributedString {
		let attributedText = NSAttributedString()
		return attributedText
	}
}

// MARK: - protocol IVisitor

protocol IVisitor {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString
}

// MARK: - Base

extension INode {
	func accept(_ visitor: IAttibuteTextVisitor) -> NSAttributedString {
		return visitor.visit(self)
	}
}

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

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

class AttibuteTextVisitor: IAttibuteTextVisitor {
	func visit(_ node: Document) -> NSAttributedString {
		let result = NSMutableAttributedString()
		
		guard let childrens = node.children as? [IVisitor] else { return NSAttributedString(string: "") }
		for child in childrens {
			result.append(child.accept(AttibuteTextVisitor()))
		}
		return result
	}
	
	func visit(_ node: HeaderNode) -> NSAttributedString {
		let result = NSMutableAttributedString()
		
		guard let childrens = node.children as? [IVisitor] else { return NSAttributedString(string: "") }
		for child in childrens {
			result.append(child.accept(AttibuteTextVisitor()))
		}
		
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.firstLineHeadIndent = 5.0
		
		let attributes: [NSAttributedString.Key: Any] = [
			.paragraphStyle: paragraphStyle,
			.font: UIFont.boldSystemFont(ofSize: 20)
		]
		result.addAttributes(attributes, range: NSRange(location: 0, length: 6))
		
		return result
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

extension NSAttributedString {
	static func singleNewline(withFontSize fontSize: CGFloat) -> NSAttributedString {
		return NSAttributedString(string: "\n", attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .regular)])
	}
	
	static func doubleNewline(withFontSize fontSize: CGFloat) -> NSAttributedString {
		return NSAttributedString(string: "\n\n", attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .regular)])
	}
}

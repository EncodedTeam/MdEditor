//
//  AttributetTextVisitor.swift
//  MdEditor
//
//  Created by Aleksey Efimov on 19.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import UIKit
import MarkdownPackage

protocol IVisitor {
	associatedtype Result
	
	func visit(_ node: Document) -> [Result]
	func visit(_ node: HeaderNode) -> Result
	func visit(_ node: BlockquoteNode) -> Result
	func visit(_ node: ParagraphNode) -> Result
	func visit(_ node: TextNode) -> Result
	func visit(_ node: BoldTextNode) -> Result
	func visit(_ node: ItalicTextNode) -> Result
	func visit(_ node: BoldItalicTextNode) -> Result
	func visit(_ node: InlineCodeTextNode) -> Result
	func visit(_ node: EscapedCharTextNode) -> Result
	func visit(_ node: LinkNode) -> Result
	func visit(_ node: ImageNode) -> Result
	func visit(_ node: LineBreakNode) -> Result
	func visit(_ node: HorizontalLineNode) -> Result
	func visit(_ node: CodeBlockNode) -> Result
	func visit(_ node: BulletedListNode) -> Result
	func visit(_ node: BulletedListItem) -> Result
	func visit(_ node: NumberedListNode) -> Result
	func visit(_ node: NumberedListItem) -> Result
}

final class AttibuteTextVisitor: IVisitor {
	func visit(_ node: Document) -> [NSMutableAttributedString] {
		visitChildren(of: node)
	}
	
	func visit(_ node: HeaderNode) -> NSMutableAttributedString {
		let code = makeMDCode(String(repeating: "#", count: node.level) + " ")
		let text = visitChildren(of: node).joined()
		
		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(String.lineBreak)
		result.append(String.lineBreak)
		
		let sizes: [CGFloat] = [34, 30, 28, 26, 24, 22]
		result.addAttribute(.font, value: UIFont.systemFont(ofSize: sizes[node.level]), range: NSRange(0..<result.length))

		return result
	}
	
	func visit(_ node: BlockquoteNode) -> NSMutableAttributedString {
		let code = makeMDCode(String(repeating: ">", count: node.level - 1) + " ")
		let text = visitChildren(of: node).joined()
		
		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(String.lineBreak)
		result.append(String.lineBreak)
		
		return result
	}
	
	func visit(_ node: ParagraphNode) -> NSMutableAttributedString {
		let result = visitChildren(of: node).joined()
		result.append(String.lineBreak)
		result.append(String.lineBreak)
		return result
	}
	
	func visit(_ node: TextNode) -> NSMutableAttributedString {
		let attribute: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.black,
			.font: UIFont.systemFont(ofSize: 18)
		]
		return NSMutableAttributedString(string: node.text, attributes: attribute)
	}
	
	func visit(_ node: BoldTextNode) -> NSMutableAttributedString {
		let code = makeMDCode("**")
		
		let attribute: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.blue,
			.font: UIFont.boldSystemFont(ofSize: 18)
		]
		let text = NSMutableAttributedString(string: node.text, attributes: attribute)
		
		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(code)
		
		return result
	}
	
	func visit(_ node: ItalicTextNode) -> NSMutableAttributedString {
		let code = makeMDCode("*")
		
		let attribute: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.blue,
			.font: UIFont.italicSystemFont(ofSize: 18)
		]
		let text = NSMutableAttributedString(string: node.text, attributes: attribute)
		
		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(code)
		
		return result
	}
	
	func visit(_ node: BoldItalicTextNode) -> NSMutableAttributedString {
		let code = makeMDCode("***")
		
		let font: UIFont
		if let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
			.withSymbolicTraits([.traitBold, .traitItalic]) {
			font = UIFont(descriptor: fontDescriptor, size: 18)
		} else {
			font = UIFont.boldSystemFont(ofSize: 18)
		}
		
		let attribute: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.blue,
			.font: font
		]
		let text = NSMutableAttributedString(string: node.text, attributes: attribute)
		
		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(code)
		
		return result
	}
	
	func visit(_ node: InlineCodeTextNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()
		return result
	}
	
	func visit(_ node: EscapedCharTextNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()
		return result
	}
	
	func visit(_ node: LinkNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()
		return result
	}
	
	func visit(_ node: ImageNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()
		return result
	}
	
	func visit(_ node: LineBreakNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()
		return result
	}
	
	func visit(_ node: HorizontalLineNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()
		return result
	}
	
	func visit(_ node: CodeBlockNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()
		return result
	}
	
	func visit(_ node: BulletedListNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()
		return result
	}
	
	func visit(_ node: BulletedListItem) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()
		return result
	}
	
	func visit(_ node: NumberedListNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()
		return result
	}
	
	func visit(_ node: NumberedListItem) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()
		return result
	}
}

extension IVisitor {
	func visitChildren(of node: INode) -> [Result] {
		return node.children.compactMap { child in // swiftlint:disable:this closure_body_length
			switch child {
			case let child as HeaderNode:
				return visit(child)
			case let child as BlockquoteNode:
				return visit(child)
			case let child as ParagraphNode:
				return visit(child)
			case let child as TextNode:
				return visit(child)
			case let child as BoldTextNode:
				return visit(child)
			case let child as ItalicTextNode:
				return visit(child)
			case let child as BoldItalicTextNode:
				return visit(child)
			case let child as InlineCodeTextNode:
				return visit(child)
			case let child as EscapedCharTextNode:
				return visit(child)
			case let child as LinkNode:
				return visit(child)
			case let child as ImageNode:
				return visit(child)
			case let child as LineBreakNode:
				return visit(child)
			case let child as HorizontalLineNode:
				return visit(child)
			case let child as CodeBlockNode:
				return visit(child)
			case let child as BulletedListNode:
				return visit(child)
			case let child as BulletedListItem:
				return visit(child)
			case let child as NumberedListNode:
				return visit(child)
			case let child as NumberedListItem:
				return visit(child)
			default:
				return nil
			}
		}
	}
}

private extension AttibuteTextVisitor {
	func makeMDCode(_ code: String) -> NSMutableAttributedString {
		let attribute: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.lightGray
		]
		return NSMutableAttributedString(string: code, attributes: attribute)
	}
}

extension Sequence where Iterator.Element == NSMutableAttributedString {
	func joined() -> NSMutableAttributedString {
		reduce(into: NSMutableAttributedString()) { $0.append($1) }
	}
}

extension String {
	var attributed: NSMutableAttributedString {
		NSMutableAttributedString(string: self)
	}
	
	static var lineBreak: NSMutableAttributedString {
		NSMutableAttributedString(string: "\n")
	}
	
	static var tab: NSMutableAttributedString {
		NSMutableAttributedString(string: "\t")
	}
}

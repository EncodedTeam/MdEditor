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
		let code = makeMdCode(String(repeating: "#", count: node.level) + " ")
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
		let code = makeMdCode(String(repeating: ">", count: node.level - 1) + " ")
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
		let code = makeMdCode("**")
		
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
		let code = makeMdCode("*")
		
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
		let code = makeMdCode("***")
		
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
		let code = makeMdCode("`")
		
		let attribute: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.gray
		]
		let text = NSMutableAttributedString(string: node.code, attributes: attribute)
		
		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(code)
//		result.addAttribute(.backgroundColor, value: UIColor.lightGray, range: NSRange(0..<result.length))
		
		return result
	}
	
	func visit(_ node: EscapedCharTextNode) -> NSMutableAttributedString {
		String.lineBreak
	}
	
	func visit(_ node: LinkNode) -> NSMutableAttributedString {
		let codeFirst = makeMdCode(" [\(node.header)](")
		let codeEnd = makeMdCode(") ")
		
		let attribute: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.blue,
			.underlineStyle: NSUnderlineStyle.single.rawValue
		]
		let link = NSMutableAttributedString(string: node.url, attributes: attribute)
		link.addAttribute(.link, value: node.url, range: NSRange(0..<link.length))
		
		let result = NSMutableAttributedString()
		result.append(codeFirst)
		result.append(link)
		result.append(codeEnd)
		
		return result
	}
	
	func visit(_ node: ImageNode) -> NSMutableAttributedString {
		let codeFirst = makeMdCode(" ![\(node.header)](")
		let codeEnd = makeMdCode(") ")
		
		let attribute: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.blue,
			.underlineStyle: NSUnderlineStyle.single.rawValue
		]
		let link = NSMutableAttributedString(string: node.url, attributes: attribute)
		link.addAttribute(.link, value: node.url, range: NSRange(0..<link.length))
		
		let result = NSMutableAttributedString()
		result.append(codeFirst)
		result.append(link)
		result.append(codeEnd)
		
		return result
	}
	
	func visit(_ node: LineBreakNode) -> NSMutableAttributedString {
		String.lineBreak
	}
	
	func visit(_ node: HorizontalLineNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()
		return result
	}
	
	func visit(_ node: CodeBlockNode) -> NSMutableAttributedString {
		let codeStart = makeMdCode("```\(node.language)")
		let codeEnd = makeMdCode("```")
		
		let text = visitChildren(of: node).joined()
		
		let result = NSMutableAttributedString()
		result.append(String.lineBreak)
		result.append(codeStart)
		result.append(String.lineBreak)
		result.append(text)
		result.append(String.lineBreak)
		result.append(codeEnd)
		result.append(String.lineBreak)
		
		let attribute: [NSAttributedString.Key: Any] = [
			.foregroundColor: Theme.mainColor
		]
		result.addAttributes(attribute, range: NSRange(0..<result.length))
		
		return result
	}
	
	func visit(_ node: BulletedListNode) -> NSMutableAttributedString {
		let level = makeMdCode(String(repeating: "  ", count: node.level))
		let text = visitChildren(of: node).joined()
		
		let result = NSMutableAttributedString()
		result.append(level)
		result.append(text)
		
		return result
	}
	
	func visit(_ node: BulletedListItem) -> NSMutableAttributedString {
		let attribute: [NSAttributedString.Key: Any] = [
			.font: UIFont.boldSystemFont(ofSize: 18)
		]
		let code = NSAttributedString(string: node.marker + " ", attributes: attribute)
		
		let text = visitChildren(of: node).joined()
		
		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(String.lineBreak)
		
		return result
	}
	
	func visit(_ node: NumberedListNode) -> NSMutableAttributedString {
		let level = makeMdCode(String(repeating: "  ", count: node.level))
		let text = visitChildren(of: node).joined()
		
		let result = NSMutableAttributedString()
		result.append(level)
		result.append(text)
		
		return result
	}
	
	func visit(_ node: NumberedListItem) -> NSMutableAttributedString {
		let attribute: [NSAttributedString.Key: Any] = [
			.font: UIFont.boldSystemFont(ofSize: 18)
		]
		let code = NSAttributedString(string: node.marker + " ", attributes: attribute)
		
		let text = visitChildren(of: node).joined()
		
		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(String.lineBreak)
		
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
	func makeMdCode(_ code: String) -> NSMutableAttributedString {
		let attribute: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.gray
		]
		return NSMutableAttributedString(string: code, attributes: attribute)
	}
}





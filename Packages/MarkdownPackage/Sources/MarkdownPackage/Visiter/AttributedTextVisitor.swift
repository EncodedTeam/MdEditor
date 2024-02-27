//
//  AttributetTextVisitor.swift
//  MdEditor
//
//  Created by Aleksey Efimov on 19.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import UIKit

public final class AttibutedTextVisitor: IVisitor {
	
	public init() { }
	
	public func visit(_ node: Document) -> [NSMutableAttributedString] {
		visitChildren(of: node)
	}
	
	public func visit(_ node: HeaderNode) -> NSMutableAttributedString {
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
	
	public func visit(_ node: BlockquoteNode) -> NSMutableAttributedString {
		let code = makeMdCode(String(repeating: ">", count: node.level - 1) + " ")
		let text = visitChildren(of: node).joined(separator: " ")
		
		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(String.lineBreak)
		result.append(String.lineBreak)
		
		return result
	}
	
	public func visit(_ node: ParagraphNode) -> NSMutableAttributedString {
		let result = visitChildren(of: node).joined(separator: " ")
		result.append(String.lineBreak)
		result.append(String.lineBreak)
		
		return result
	}
	
	public func visit(_ node: TextNode) -> NSMutableAttributedString {
		let attribute: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.black,
			.font: UIFont.systemFont(ofSize: 18)
		]
		return NSMutableAttributedString(string: node.text, attributes: attribute)
	}
	
	public func visit(_ node: BoldTextNode) -> NSMutableAttributedString {
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
	
	public func visit(_ node: ItalicTextNode) -> NSMutableAttributedString {
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
	
	public func visit(_ node: BoldItalicTextNode) -> NSMutableAttributedString {
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
	
	public func visit(_ node: InlineCodeTextNode) -> NSMutableAttributedString {
		let code = makeMdCode("`")
		
		let attribute: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.gray
		]
		let text = NSMutableAttributedString(string: node.code, attributes: attribute)
		
		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(code)
		
		return result
	}
	
	public func visit(_ node: EscapedCharTextNode) -> NSMutableAttributedString {
		let code = makeMdCode("\\")
		
		let attribute: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.gray,
			.font: UIFont.systemFont(ofSize: 18)
		]
		let text = NSMutableAttributedString(string: node.char, attributes: attribute)
		
		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		
		return result
	}
	
	public func visit(_ node: LinkNode) -> NSMutableAttributedString {
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
	
	public func visit(_ node: ImageNode) -> NSMutableAttributedString {
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
	
	public func visit(_ node: LineBreakNode) -> NSMutableAttributedString {
		String.lineBreak
	}
	
	public func visit(_ node: HorizontalLineNode) -> NSMutableAttributedString {
		let result = NSMutableAttributedString()
		return result
	}
	
	public func visit(_ node: CodeBlockNode) -> NSMutableAttributedString {
		let codeStart = makeMdCode("```\(node.language)")
		let codeEnd = makeMdCode("```")
		
		let text = visitChildren(of: node).joined(separator: "\n")
		
		let result = NSMutableAttributedString()
		result.append(String.lineBreak)
		result.append(codeStart)
		result.append(String.lineBreak)
		result.append(text)
		result.append(String.lineBreak)
		result.append(codeEnd)
		result.append(String.lineBreak)
		
		let attribute: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.green
		]
		result.addAttributes(attribute, range: NSRange(0..<result.length))
		
		return result
	}
	
	public func visit(_ node: BulletedListNode) -> NSMutableAttributedString {
		let level = makeMdCode(String(repeating: "  ", count: node.level))
		let text = visitChildren(of: node).joined()
		
		let result = NSMutableAttributedString()
		result.append(level)
		result.append(text)
		
		return result
	}
	
	public func visit(_ node: BulletedListItem) -> NSMutableAttributedString {
		let attribute: [NSAttributedString.Key: Any] = [
			.font: UIFont.systemFont(ofSize: 18)
		]
		let code = NSAttributedString(string: node.marker + " ", attributes: attribute)
		
		let text = visitChildren(of: node).joined()
		
		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(String.lineBreak)
		
		return result
	}
	
	public func visit(_ node: NumberedListNode) -> NSMutableAttributedString {
		let level = makeMdCode(String(repeating: " ", count: node.level))
		let text = visitChildren(of: node).joined()
		
		let result = NSMutableAttributedString()
		result.append(level)
		result.append(text)
		
		return result
	}
	
	public func visit(_ node: NumberedListItem) -> NSMutableAttributedString {
		let attribute: [NSAttributedString.Key: Any] = [
			.font: UIFont.systemFont(ofSize: 18)
		]
		let code = NSAttributedString(string: node.marker + " ", attributes: attribute)
		
		let text = visitChildren(of: node).joined()
		
		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		
		return result
	}
}

private extension AttibutedTextVisitor {
	func makeMdCode(_ code: String) -> NSMutableAttributedString {
		let attribute: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.gray
		]
		return NSMutableAttributedString(string: code, attributes: attribute)
	}
}

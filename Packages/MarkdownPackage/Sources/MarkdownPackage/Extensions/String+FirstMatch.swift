//
//  String+FirstMatch.swift
//
//
//  Created by Aksilont on 16.02.2024.
//

import Foundation

public extension String {
	func firstMatch(pattern: Self) throws  -> NSTextCheckingResult? {
		let fullRange = NSRange(startIndex..., in: self)
		let regexp = try NSRegularExpression(pattern: pattern)
		return regexp.firstMatch(in: self, range: fullRange)
	}

	func substring(with range: NSRange) -> Self {
		(self as NSString).substring(with: range)
	}
}

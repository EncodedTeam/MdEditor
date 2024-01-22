//
// MdEditorTests.swift
//

import UIKit

protocol Accessible {
	func generateAccessibilityIdentifiers()
}

extension Accessible {
	
	func generateAccessibilityIdentifiers() {
#if DEBUG
		let mirror = Mirror(reflecting: self)
		
		for child in mirror.children {
			if
				let view = child.value as? UIView,
				var identifier = child.label {
				identifier = identifier.replacingOccurrences(of: ".storage", with: "")
				identifier = identifier.replacingOccurrences(of: "$__lazy_storage_$_", with: "")

				view.accessibilityIdentifier = "\(type(of: self)).\(identifier)"
			}
		}
#endif
	}
}

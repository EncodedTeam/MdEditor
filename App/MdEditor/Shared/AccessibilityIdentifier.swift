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

enum AccessibilityIdentifier: CustomStringConvertible {
	case tableView
	case section(index: Int)
	case cell(section: Int, row: Int)

	var controller: AvailableControllers { .TodoListViewController }

	var description: String {
		switch self {
		case .tableView:
			return "TodoListViewController.tableView"
		case .section(let index):
			return "TodoListViewController.section-\(index)"
		case .cell(let section, let row):
			return "TodoListViewController.cell-\(section)-\(row)"
		}
	}
}

enum AvailableControllers: String {
	case LoginViewController
	case TodoListViewController
}

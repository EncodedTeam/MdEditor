//
//  TodoListScreenObject.swift
//  MdEditor
//
//  Created by Aksilont on 20.01.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import XCTest

final class TodoListScreenObject: BaseScreenObject {
	// MARK: - Private properties
	private lazy var tableView = app.tables["TodoListVC.tableView"]

	// MARK: - ScreenObject Methods
	@discardableResult
	func isTodoListScreen() -> Self {
		assert(tableView, [.exists])

		return self
	}

	@discardableResult
	func tapOnCell() -> Self {
		assert(tableView, [.exists])

		let completedSection = L10n.SectionForTaskManagerAdapter.completed
		let uncompletedSection = L10n.SectionForTaskManagerAdapter.uncompleted

		var cell = tableView.cells["TodoListVC.Cell(0,0)"]
		let titleTaskResult = "!!! Do homework"
		var titleTask = cell.staticTexts[titleTaskResult]
		XCTAssertEqual(titleTask.label, titleTaskResult, "Should be equal \(titleTaskResult)")
//		var deadlineTask = cell.staticTexts[""]
		assert(cell, [.exists])
//		assert(titleTask, [.exists])
//		assert(deadlineTask, [.exists])
		assert(cell, [.isNotSelected])
		cell.tap()

		cell = tableView.cells["TodoListVC.Cell(1,0)"]
		titleTask = cell.staticTexts[titleTaskResult]
//		deadlineTask = cell.staticTexts[""]
		assert(cell, [.exists])
		assert(titleTask, [.exists])
//		assert(deadlineTask, [.exists])
		assert(cell, [.isSelected])
		cell.tap()

		cell = tableView.cells["TodoListVC.Cell(0,0)"]
		titleTask = cell.staticTexts[titleTaskResult]
//		deadlineTask = cell.staticTexts[""]
		assert(cell, [.exists])
		assert(titleTask, [.exists])
//		assert(deadlineTask, [.exists])
		assert(cell, [.isNotSelected])

		return self
	}
}

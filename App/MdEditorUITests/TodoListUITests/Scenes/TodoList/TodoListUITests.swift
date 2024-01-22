//
//  TodoListUITests.swift
//  MdEditorUITests
//
//  Created by Aksilont on 20.01.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import XCTest

final class TodoListUITests: XCTestCase {
	
	func test_todoList_withTapOnCell_shouldBeSuccess() {
		let app = XCUIApplication()
		let loginScreen = LoginScreenObject(app: app)
		let todoScreen = TodoListScreenObject(app: app)
		app.launchArguments.append("isStubbing")
		app.launch()

		loginScreen
			.isLoginScreen()
			.login()

		todoScreen
			.isTodoListScreen()
			.tapOnCell()
	}
}

//
//  LoginUITests.swift
//  MdEditorUITests
//

import XCTest

final class LoginUITests: XCTestCase {

	func test_login_withValidCred_mustBeSuccess() {
		let app = XCUIApplication()
		let loginScreen = LoginScreenObject(app: app)
		let todoScreen = TodoListScreenObject(app: app)
		app.launchArguments.append(LaunchArguments.isUItesting)
		app.launchArguments.append(contentsOf: LaunchArguments.appLanguage)
		app.launch()

		loginScreen
			.isLoginScreen()
			.set(login: "Login")
			.set(password: "Password")
			.login()

		todoScreen
			.isTodoListScreen()
	}

	func test_login_withInValidCred_mustBeShowAlert() {
		let app = XCUIApplication()
		let loginScreen = LoginScreenObject(app: app)
		app.launchArguments.append(LaunchArguments.isUItesting)
		app.launchArguments.append(contentsOf: LaunchArguments.appLanguage)
		app.launch()

		loginScreen
			.isLoginScreen()
			.set(login: "wrongLogin")
			.set(password: "wrongPass")
			.login()
			.closeAlert()
	}
}

//
//  LoginSceneUITest.swift
//  TodoListUITests
//
//  Created by Kirill Leonov on 03.04.2023.
//

import XCTest

final class LoginSceneUITest: XCTestCase {

	func test_login_withValidCred_mustBeSuccess() {
		let app = XCUIApplication()
		let loginScreen = LoginScreenObject(app: app)
		app.launch()
	
		loginScreen
			.isLoginScreen()
			.set(login: "Admin")
			.set(password: "pa$$32!")
			.login()
		// TODO: Проверить, что преходит на тудулист сцену
	}

	func test_login_withInValidCred_mustBeShowAlert() {
		let app = XCUIApplication()
		let loginScreen = LoginScreenObject(app: app)
		app.launch()

		loginScreen
			.isLoginScreen()
			.set(password: "user")
			.set(login: "wrongPass")
			.login()
			.closeAlert()
	}
}

//
//  LoginScreenObject.swift
//  TodoListUITests
//
//  Created by Kirill Leonov on 05.04.2023.
//

import XCTest

final class LoginScreenObject: BaseScreenObject {
	
	// MARK: - Private properties

	private lazy var textFieldLogin = app.textFields["LoginViewController.textFieldLogin"]
	private lazy var textFieldPass = app.secureTextFields["LoginViewController.textFieldPass"]
	private lazy var loginButton = app.buttons["LoginViewController.buttonLogin"]
	private lazy var alert = app.alerts.firstMatch

	// MARK: - ScreenObject Methods

	@discardableResult
	func isLoginScreen() -> Self {
		assert(textFieldLogin, [.exists])
		assert(textFieldPass, [.exists])
		assert(loginButton, [.exists])

		return self
	}
	
	@discardableResult
	func set(login: String) -> Self {
		assert(textFieldLogin, [.exists])
		textFieldLogin.tap()
		textFieldLogin.typeText(login)
		
		return self
	}
	
	@discardableResult
	func set(password: String) -> Self {
		assert(textFieldPass, [.exists])
		textFieldPass.tap()
		textFieldPass.typeText(password)
		
		return self
	}
	
	@discardableResult
	func login() -> Self {
		assert(loginButton, [.exists])
		loginButton.tap()
		
		return self
	}

	@discardableResult
	func closeAlert() -> Self {
		assert(alert, [.exists])
		alert.buttons.firstMatch.tap()

		return self
	}
}

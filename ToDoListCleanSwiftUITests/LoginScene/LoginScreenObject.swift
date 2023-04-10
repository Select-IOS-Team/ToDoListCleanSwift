//
//  LoginScreenObject.swift
//  ToDoListCleanSwiftUITests
//
//  Created by Evgeni Meleshin on 10.04.2023.
//

import XCTest

class LoginScreenObject: BaseScreenObject {

	// MARK: - Private properties

	private lazy var loginTextField = app.textFields[AccessibilityIdentifier.loginTextField.rawValue]
	private lazy var passwordTextField = app.secureTextFields[AccessibilityIdentifier.passwordTextField.rawValue]
	private lazy var loginButton = app.buttons[AccessibilityIdentifier.loginButton.rawValue]

	// MARK: - ScreenObject Methods

	@discardableResult
	func isLoginScreen() -> Self {
		assert(loginTextField, [.exists])
		assert(passwordTextField, [.exists])
		assert(loginButton, [.exists])
		return self
	}

	@discardableResult
	func set(login: String) -> Self {
		assert(loginTextField, [.exists])
		loginTextField.tap()
		loginTextField.typeText(login)
		return self
	}

	@discardableResult
	func set(password: String) -> Self {
		assert(passwordTextField, [.exists])
		passwordTextField.tap()
		passwordTextField.typeText(password)
		return self
	}

	@discardableResult
	func login() -> Self {
		assert(loginButton, [.exists])
		loginButton.tap()
		return self
	}
}

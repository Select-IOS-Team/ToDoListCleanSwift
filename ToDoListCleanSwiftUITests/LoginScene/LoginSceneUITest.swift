//
//  LoginSceneUITest.swift
//  ToDoListCleanSwiftUITests
//
//  Created by Evgeni Meleshin on 10.04.2023.
//

import XCTest

// swiftlint: disable all
final class LoginSceneUITest: XCTestCase {

	func test_login_withValidCredentials_shouldBeSuccess() {
		let app = XCUIApplication()
		let loginScreen = LoginScreenObject(app: app)

		app.launch()

		loginScreen
			.isLoginScreen()
			.set(login: "1")
			.set(password: "1")
			.login()
	}

	func test_login_withInvalidCredentials_shouldBeFailure() {
		let app = XCUIApplication()
		let loginScreen = LoginScreenObject(app: app)

		app.launch()

		loginScreen
			.isLoginScreen()
			.set(login: "2")
			.set(password: "2")
			.login()
	}

}
// swiftlint: enable all

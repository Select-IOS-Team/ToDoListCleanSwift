//
//  LoginPresenterTests.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeniy Novgorodov on 26.03.2023.
//

import XCTest
@testable import ToDoListCleanSwift

final class LoginPresenterTests: XCTestCase {

	// MARK: - Private properties

	private var loginViewControllerSpy: LoginViewControllerSpy! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: - Tests

	func test_present_dataToViewShouldBeCorrect() {
		// arrange
		let sut = makeSut()
		let response = LoginModels.Response(success: true, login: "login")

		// act
		sut.present(response: response)

		// assert
		XCTAssertTrue(loginViewControllerSpy.invokedRender, "У вью не был вызван требуемый вызова метод render")
		XCTAssertEqual(
			loginViewControllerSpy.invokedRenderParameters?.viewModel.success,
			true,
			"Передаваемый во вью значение об успешной авторизации отличается полученного в response"
		)
		XCTAssertEqual(
			loginViewControllerSpy.invokedRenderParameters?.viewModel.userName,
			response.login,
			"Передаваемый во вью логин отличается от полученного в response"
		)
	}
}

// MARK: - Private

private extension LoginPresenterTests {

	func makeSut() -> LoginPresenter {
		loginViewControllerSpy = LoginViewControllerSpy()
		return LoginPresenter(viewController: loginViewControllerSpy)
	}
}

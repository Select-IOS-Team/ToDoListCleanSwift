//
//  LoginInteractorTests.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeniy Novgorodov on 26.03.2023.
//

import XCTest
@testable import ToDoListCleanSwift

final class LoginInteractorTests: XCTestCase {

	// MARK: - Private properties

	private var loginWorkerSpy: LoginWorkerSpy! // swiftlint:disable:this implicitly_unwrapped_optional
	private var loginPresenterSpy: LoginPresenterSpy! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: - Tests

	// Проверка того, что передаваемые в воркер и в презентер данные, корректны, когда авторизация успешна
	func test_login_withSuccessLogin_dataToWorkerAndToPresenterShouldBeCorrect() {
		// arrange
		let sut = makeSut()
		let request = LoginModels.Request(login: "login", password: "password")
		let expectedLoginDTO = LoginDTO(success: 1, login: "workerLogin")
		loginWorkerSpy.stubbedLoginResult = expectedLoginDTO

		// act
		sut.login(request: request)

		// assert
		XCTAssertTrue(loginWorkerSpy.invokedLogin, "У воркера не был вызван требуемый вызова метод login")
		XCTAssertEqual(
			loginWorkerSpy.invokedLoginParameters?.login,
			request.login,
			"Передаваемый в воркер логин отличается от логина в реквесте"
		)
		XCTAssertEqual(
			loginWorkerSpy.invokedLoginParameters?.password,
			request.password,
			"Передаваемый в воркер пароль отличается от пароля в реквесте"
		)
		XCTAssertTrue(loginPresenterSpy.invokedPresent, "У презентера не был вызван требуемый вызова метод present")
		XCTAssertEqual(
			loginPresenterSpy.invokedPresentParameters?.response.success,
			true,
			"Передаваемое в презентер значение об успешной авторизации отличается от ожидаемого (true)"
		)
		XCTAssertEqual(
			loginPresenterSpy.invokedPresentParameters?.response.login,
			expectedLoginDTO.login,
			"Передаваемый в презентер логин отличается от логина, полученного от воркера"
		)
	}

	// Проверка того, что передаваемые в воркер и в презентер данные, корректны, когда авторизация неуспешна
	func test_login_withFailureLogin_dataToWorkerAndToPresenterShouldBeCorrect() {
		// arrange
		let sut = makeSut()
		let request = LoginModels.Request(login: "login", password: "password")
		let expectedLoginDTO = LoginDTO(success: 0, login: "workerLogin")
		loginWorkerSpy.stubbedLoginResult = expectedLoginDTO

		// act
		sut.login(request: request)

		// assert
		XCTAssertTrue(loginWorkerSpy.invokedLogin, "У воркера не был вызван требуемый вызова метод login")
		XCTAssertEqual(
			loginWorkerSpy.invokedLoginParameters?.login,
			request.login,
			"Передаваемый в воркер логин отличается от логина в реквесте"
		)
		XCTAssertEqual(
			loginWorkerSpy.invokedLoginParameters?.password,
			request.password,
			"Передаваемый в воркер пароль отличается от пароля в реквесте"
		)
		XCTAssertTrue(loginPresenterSpy.invokedPresent, "У презентера не был вызван требуемый вызова метод present")
		XCTAssertEqual(
			loginPresenterSpy.invokedPresentParameters?.response.success,
			false,
			"Передаваемое в презентер значение об успешной авторизации отличается от ожидаемого (false)"
		)
		XCTAssertEqual(
			loginPresenterSpy.invokedPresentParameters?.response.login,
			expectedLoginDTO.login,
			"Передаваемый в презентер логин отличается от логина, полученного от воркера"
		)
	}
}

// MARK: - Private

private extension LoginInteractorTests {

	func makeSut() -> LoginInteractor {
		loginWorkerSpy = LoginWorkerSpy()
		loginPresenterSpy = LoginPresenterSpy()
		return LoginInteractor(worker: loginWorkerSpy, presenter: loginPresenterSpy)
	}
}

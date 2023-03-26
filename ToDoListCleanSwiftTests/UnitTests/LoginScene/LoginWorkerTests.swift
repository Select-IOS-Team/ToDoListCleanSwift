//
//  LoginWorkerTests.swift
//  ToDoListCleanSwiftTests
//
//  Created by SERGEY SHLYAKHIN on 25.03.2023.
//

import XCTest
@testable import ToDoListCleanSwift

final class LoginWorkerTests: XCTestCase {

	// MARK: - Tests

	func test_login_withValidData_shouldEqualWithValidLoginDTO() {
		// arrange
		let sut = LoginWorker()

		// act
		let result = sut.login(login: "1", password: "1")

		// assert
		XCTAssertEqual(result, StubData.validLoginDTO, "Не соответствует валидному ответу")
	}

	func test_login_withInvalidPassword_shouldEqualWithinvalidPasswordLoginDTO() {
		// arrange
		let sut = LoginWorker()

		// act
		let result = sut.login(login: "1", password: "0")

		// assert
		XCTAssertEqual(result, StubData.invalidPasswordLoginDTO, "Не соответствует ответу для неверного пароля")
	}

	func test_login_withInvalidLogin_shouldEqualWithInvalidLoginLoginDTO() {
		// arrange
		let sut = LoginWorker()

		// act
		let result = sut.login(login: "0", password: "1")

		// assert
		XCTAssertEqual(result, StubData.invalidLoginLoginDTO, "Не соответствует ответу для неверного логина")
	}

	func test_login_withInvalidAllData_shouldEqualWithInvalidDataLoginDTO() {
		// arrange
		let sut = LoginWorker()

		// act
		let result = sut.login(login: "0", password: "0")

		// assert
		XCTAssertEqual(result, StubData.invalidDataLoginDTO, "Не соответствует ответу для неверных логина и пароля")
	}
}

// MARK: - TestData

private extension LoginWorkerTests {

	enum StubData {
		static let validLoginDTO = LoginDTO(success: 1, login: "1")
		static let invalidPasswordLoginDTO = LoginDTO(success: 0, login: "1")
		static let invalidLoginLoginDTO = LoginDTO(success: 0, login: "0")
		static let invalidDataLoginDTO = LoginDTO(success: 0, login: "0")
	}
}

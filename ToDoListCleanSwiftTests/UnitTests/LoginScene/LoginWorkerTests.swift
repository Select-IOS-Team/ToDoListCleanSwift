//
//  LoginWorkerTests.swift
//  ToDoListCleanSwiftTests
//
//  Created by SERGEY SHLYAKHIN on 25.03.2023.
//

import XCTest
@testable import ToDoListCleanSwift

final class LoginWorkerTests: XCTestCase {

	private let validLoginDTO = LoginDTO(success: 1, login: "1")
	private let invalidPasswordLoginDTO = LoginDTO(success: 0, login: "1")
	private let invalidLoginLoginDTO = LoginDTO(success: 0, login: "0")

	func test_login_withValidData_shouldEqualWithValidLoginDTO() {
		let sut = LoginWorker()

		let result = sut.login(login: "1", password: "1")

		XCTAssertEqual(result, validLoginDTO, "Не соответствует валидному ответу")
	}

	func test_login_withInvalidPassword_shouldEqualWithinvalidPasswordLoginDTO() {
		let sut = LoginWorker()

		let result = sut.login(login: "1", password: "0")

		XCTAssertEqual(result, invalidPasswordLoginDTO, "Не соответствует ответу для неверного пароля")
	}

	func test_login_withInvalidLogin_shouldEqualWithInvalidLoginLoginDTO() {
		let sut = LoginWorker()

		let result = sut.login(login: "0", password: "1")

		XCTAssertEqual(result, invalidPasswordLoginDTO, "Не соответствует ответу для неверного логина")
	}
}

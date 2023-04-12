//
//  LoginWorkerSpy.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeniy Novgorodov on 26.03.2023.
//

@testable import ToDoListCleanSwift

final class LoginWorkerSpy: ILoginWorker {

	// MARK: - Internal properties

	var invokedLogin = false
	var invokedLoginCount = 0
	var invokedLoginParameters: (login: String, password: String)?
	var invokedLoginParametersList = [(login: String, password: String)]()
	// swiftlint: disable implicitly_unwrapped_optional
	var stubbedLoginResult: LoginDTO!
	// swiftlint: enable implicitly_unwrapped_optional

	// MARK: - ILoginWorker

	func login(login: String, password: String) -> LoginDTO {
		invokedLogin = true
		invokedLoginCount += 1
		invokedLoginParameters = (login, password)
		invokedLoginParametersList.append((login, password))
		return stubbedLoginResult
	}
}
// swiftlint:enable implicitly_unwrapped_optional

//
//  LoginPresenterSpy.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeniy Novgorodov on 26.03.2023.
//

@testable import ToDoListCleanSwift

final class LoginPresenterSpy: ILoginPresenter {

	// MARK: - Internal properties

	var invokedPresent = false
	var invokedPresentCount = 0
	var invokedPresentParameters: (response: LoginModels.Response, Void)?
	var invokedPresentParametersList = [(response: LoginModels.Response, Void)]()

	// MARK: - ILoginPresenter

	func present(response: LoginModels.Response) {
		invokedPresent = true
		invokedPresentCount += 1
		invokedPresentParameters = (response, ())
		invokedPresentParametersList.append((response, ()))
	}
}

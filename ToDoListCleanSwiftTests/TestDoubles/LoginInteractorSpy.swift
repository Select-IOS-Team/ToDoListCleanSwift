//
//  LoginInteractorSpy.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeniy Novgorodov on 07.04.2023.
//

@testable import ToDoListCleanSwift

final class LoginInteractorSpy: ILoginInteractor {

	var invokedLogin = false
	var invokedLoginCount = 0
	var invokedLoginParameters: (request: LoginModels.Request, Void)?
	var invokedLoginParametersList = [(request: LoginModels.Request, Void)]()

	func login(request: LoginModels.Request) {
		invokedLogin = true
		invokedLoginCount += 1
		invokedLoginParameters = (request, ())
		invokedLoginParametersList.append((request, ()))
	}
}

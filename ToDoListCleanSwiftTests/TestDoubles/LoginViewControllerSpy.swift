//
//  LoginViewControllerSpy.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeniy Novgorodov on 26.03.2023.
//

@testable import ToDoListCleanSwift

final class LoginViewControllerSpy: ILoginViewController {

	// MARK: - Internal properties

	var invokedRender = false
	var invokedRenderCount = 0
	var invokedRenderParameters: (viewModel: LoginModels.ViewModel, Void)?
	var invokedRenderParametersList = [(viewModel: LoginModels.ViewModel, Void)]()

	// MARK: - ILoginViewController

	func render(viewModel: LoginModels.ViewModel) {
		invokedRender = true
		invokedRenderCount += 1
		invokedRenderParameters = (viewModel, ())
		invokedRenderParametersList.append((viewModel, ()))
	}
}

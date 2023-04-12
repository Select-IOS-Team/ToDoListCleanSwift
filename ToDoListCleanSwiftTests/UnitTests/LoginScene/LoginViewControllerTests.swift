//
//  LoginViewControllerTests.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeniy Novgorodov on 07.04.2023.
//

import XCTest
@testable import ToDoListCleanSwift

final class LoginViewControllerTests: XCTestCase {

	// MARK: - Private properties

	private var mainRouterSpy: MainRouterSpy! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: - Tests

	// Проверка вызова у роутера перехода к экрану списка задач в случае получения вью модели с успешной авторизацией
	func test_render_withSuccess_shouldInvokeRouteToTasksViewController() {
		// arrange
		let sut = makeSut()
		let viewModel = LoginModels.ViewModel(success: true, userName: "Name")

		// act
		sut.render(viewModel: viewModel)

		// assert
		XCTAssertTrue(
			mainRouterSpy.invokedRouteToTasksViewController,
			"Не был вызван router.routeToTasksViewController()"
		)
	}

	// Проверка отсутствия вызова у роутера перехода к экрану списка задач
	// в случае получения вью модели с неуспешной авторизацией
	func test_render_withoutSuccess_shouldNotInvokeRouteToTasksViewController() {
		// arrange
		let sut = makeSut()
		let viewModel = LoginModels.ViewModel(success: false, userName: "Name")

		// act
		sut.render(viewModel: viewModel)

		// assert
		XCTAssertFalse(mainRouterSpy.invokedRouteToTasksViewController, "Был вызван router.routeToTasksViewController()")
	}
}

// MARK: - Private

private extension LoginViewControllerTests {

	func makeSut() -> LoginViewController {
		let loginInteractorSpy = LoginInteractorSpy()
		mainRouterSpy = MainRouterSpy()
		let loginViewController = LoginViewController(interactor: loginInteractorSpy, router: mainRouterSpy)
		return loginViewController
	}
}

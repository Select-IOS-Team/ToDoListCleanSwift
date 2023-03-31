//
//  LoginPresenter.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//

import Foundation

/// Презентер сцены авторизации.
protocol ILoginPresenter {
	/// Подготавливает презентационные данные для вью.
	/// - Parameter response: Модель данных ответа интерактора на запрос авторизации.
	func present(response: LoginModels.Response)
}

/// Презентер сцены авторизации.
final class LoginPresenter: ILoginPresenter {

	// MARK: - Private properties

	private weak var viewController: ILoginViewController?

	// MARK: - Lifecycle

	init(viewController: ILoginViewController) {
		self.viewController = viewController
	}

	// MARK: - ILoginPresenter

	func present(response: LoginModels.Response) {
		let viewModel = LoginModels.ViewModel(
			success: response.success,
			userName: response.login
		)
		viewController?.render(viewModel: viewModel)
	}
}

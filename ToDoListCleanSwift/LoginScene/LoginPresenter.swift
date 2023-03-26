//
//  LoginPresenter.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//

import Foundation

protocol ILoginPresenter {
	func present(response: LoginModels.Response)
}

class LoginPresenter: ILoginPresenter {

	private weak var viewController: ILoginViewController?

	init(viewController: ILoginViewController) {
		self.viewController = viewController
	}

	func present(response: LoginModels.Response) {
		let viewModel = LoginModels.ViewModel(
			success: response.success,
			userName: response.login
		)
		viewController?.render(viewModel: viewModel)
	}
}

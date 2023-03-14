//
//  LoginInteractor.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//

import Foundation

protocol ILoginInteractor {
	func login(request: LoginModels.Request)
}

class LoginInteractor: ILoginInteractor {

	private var worker: ILoginWorker
	private var presenter: ILoginPresenter

	init(worker: ILoginWorker, presenter: ILoginPresenter) {
		self.worker = worker
		self.presenter = presenter
	}

	func login(request: LoginModels.Request) {
		let result = worker.login(login: request.login, password: request.password)
		let response = LoginModels.Response(
			success: result.success == 1,
			login: result.login,
			lastLoginDate: result.lastLoginDate
		)
		presenter.present(response: response)
	}
}

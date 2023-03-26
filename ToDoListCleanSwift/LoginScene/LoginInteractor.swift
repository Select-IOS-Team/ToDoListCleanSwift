//
//  LoginInteractor.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//

import Foundation

/// Интерактор сцены авторизации.
protocol ILoginInteractor {
	func login(request: LoginModels.Request)
}

/// Интерактор сцены авторизации.
final class LoginInteractor: ILoginInteractor {

	// MARK: - Private properties

	private let worker: ILoginWorker
	private let presenter: ILoginPresenter

	// MARK: - Lifecycle

	init(worker: ILoginWorker, presenter: ILoginPresenter) {
		self.worker = worker
		self.presenter = presenter
	}

	// MARK: - ILoginInteractor

	func login(request: LoginModels.Request) {
		let result = worker.login(login: request.login, password: request.password)
		let response = LoginModels.Response(
			success: result.success == 1,
			login: result.login
		)
		presenter.present(response: response)
	}
}

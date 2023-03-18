//
//  ViewController.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//

import UIKit

protocol ILoginViewController: AnyObject {
	func render(viewModel: LoginModels.ViewModel)
}

class LoginViewController: UIViewController {

	var interactor: ILoginInteractor?
	private var router: IMainRouter?

	@IBOutlet private weak var textFieldLogin: UITextField!
	@IBOutlet private weak var textFieldPassword: UITextField!
	@IBAction private func loginButton(_ sender: UIButton) {
		if let login = textFieldLogin.text, let password = textFieldPassword.text {
			let request = LoginModels.Request(login: login, password: password)
			interactor?.login(request: request)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension LoginViewController: ILoginViewController {

	public func render(viewModel: LoginModels.ViewModel) {
		if viewModel.success {
			showAlert(title: "Success!", message: viewModel.userName) { _ in
				let router = MainRouter(loginViewController: self)
				router.routeToTasksViewController()
			}
		} else {
			showAlert(title: "Error", message: "")
		}
	}

	private func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
		let alert = UIAlertController(
			title: title,
			message: message,
			preferredStyle: .alert
		)
		let action = UIAlertAction(title: "OK", style: .default, handler: completion)
		alert.addAction(action)
		present(alert, animated: true)
	}
}

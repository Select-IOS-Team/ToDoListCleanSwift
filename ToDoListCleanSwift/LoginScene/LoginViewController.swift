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

	private var interactor: ILoginInteractor?
	private var router = MainRouter()
	
	@IBOutlet weak var textFieldLogin: UITextField!
	@IBOutlet weak var textFieldPassword: UITextField!
	@IBAction func loginButton(_ sender: UIButton) {
		if let login = textFieldLogin.text, let password = textFieldPassword.text {
			let request = LoginModels.Request(login: login, password: password)
			interactor?.login(request: request)
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		assembly()
	}

	func assembly() {
		let worker = LoginWorker()
		let presenter = LoginPresenter(viewController: self)
		interactor = LoginInteractor(worker: worker, presenter: presenter)
	}

}

extension LoginViewController: ILoginViewController {
	
	func render(viewModel: LoginModels.ViewModel) {
		let alert: UIAlertController
		if viewModel.success {
			alert = UIAlertController(
				title: "Success",
				message: viewModel.userName,
				preferredStyle: .alert)
		} else {
			alert = UIAlertController(
				title: "Error",
				message: "",
				preferredStyle: .alert)
		}
		let action = UIAlertAction(title: "Ok", style: .default) { [weak self] UIAlertAction in
			if viewModel.success {
				guard let self else { return }
				self.router.loginViewController = self
				self.router.routeToSomewhere()
			}
		}
		alert.addAction(action)
		present(alert, animated: true)
	}
	
}

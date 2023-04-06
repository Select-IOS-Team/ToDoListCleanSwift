//
//  ViewController.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//

import UIKit

/// Вью контроллер сцены авторизации.
protocol ILoginViewController: AnyObject {
	/// Отображает данные, соответствующие переданной модели.
	func render(viewModel: LoginModels.ViewModel)
}

/// Вью контроллер сцены авторизации.
final class LoginViewController: UIViewController {

	// MARK: - Nested types

	private enum Constants {
		static let loginTextFieldPlaceholder = "Login"
		static let passwordTextFieldPlaceholder = "Password"
		static let signInButtonTitle = "Sign in"
		static let signInButtonCornerRadius: CGFloat = 6
		static let textFieldSize = CGSize(width: 250, height: 40)
		static let loginButtonSize = CGSize(width: 100, height: 40)
		static let betweenTextFieldsSpace: CGFloat = 27
		static let loginButtonTopSpace: CGFloat = 64
	}

	// MARK: - Private properties

	private let interactor: ILoginInteractor
	private let router: IMainRouter

	private lazy var loginTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = Constants.loginTextFieldPlaceholder
		textField.borderStyle = .roundedRect
		textField.textContentType = .username
		textField.accessibilityIdentifier = AccessibilityIdentifier.loginTextField.rawValue
		return textField
	}()
	private lazy var passwordTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = Constants.passwordTextFieldPlaceholder
		textField.borderStyle = .roundedRect
		textField.textContentType = .password
		textField.isSecureTextEntry = true
		textField.accessibilityIdentifier = AccessibilityIdentifier.passwordTextField.rawValue
		return textField
	}()
	private lazy var loginButton: UIButton = {
		let button = UIButton()
		button.setTitle(Constants.signInButtonTitle, for: .normal)
		button.backgroundColor = .systemBlue
		button.layer.cornerRadius = Constants.signInButtonCornerRadius
		button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
		button.accessibilityIdentifier = AccessibilityIdentifier.loginButton.rawValue
		return button
	}()

	// MARK: - Lifecycle

	init(interactor: ILoginInteractor, router: IMainRouter) {
		self.interactor = interactor
		self.router = router
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		setupLayout()
	}
}

// MARK: - ILoginViewController

extension LoginViewController: ILoginViewController {

	public func render(viewModel: LoginModels.ViewModel) {
		if viewModel.success {
			router.routeToTasksViewController()
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

// MARK: - Private methods

private extension LoginViewController {

	func setupUI() {
		view.backgroundColor = .white
		view.addSubview(loginTextField)
		view.addSubview(passwordTextField)
		view.addSubview(loginButton)
	}

	func setupLayout() {
		passwordTextField.pin
			.center()
			.size(Constants.textFieldSize)

		loginTextField.pin
			.above(of: passwordTextField, aligned: .center)
			.size(Constants.textFieldSize)
			.marginBottom(Constants.betweenTextFieldsSpace)

		loginButton.pin
			.below(of: passwordTextField, aligned: .center)
			.size(Constants.loginButtonSize)
			.marginTop(Constants.loginButtonTopSpace)
	}

	@objc
	func didTapLoginButton(_ sender: UIButton) {
		guard let login = loginTextField.text,
			  let password = passwordTextField.text else { return }
		let request = LoginModels.Request(login: login, password: password)
		interactor.login(request: request)
	}
}

//
//  SceneDelegate.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let windowScene = (scene as? UIWindowScene) else { return }

		self.window = UIWindow(windowScene: windowScene)
		self.window?.rootViewController = loginSceneAssembler()
		self.window?.makeKeyAndVisible()
	}

	private func loginSceneAssembler() -> UIViewController {
		let presenter = LoginPresenter()
		let worker = LoginWorker()
		let interactor = LoginInteractor(worker: worker, presenter: presenter)
		let router = MainRouter()
		let viewController = LoginViewController(interactor: interactor, router: router)

		router.loginViewController = viewController
		presenter.viewController = viewController
		return viewController
	}
}

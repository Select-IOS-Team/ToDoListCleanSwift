//
//  SceneDelegate.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		
		self.window = UIWindow(windowScene: windowScene)
		self.window?.rootViewController = loginSceneAssembler()
		self.window?.makeKeyAndVisible()
	}
	
	private func loginSceneAssembler() -> UIViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		guard let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
				as? LoginViewController
		else {
			fatalError("На Main.storyboard отсутствует LoginViewController!")
		}
		
		let worker = LoginWorker()
		let presenter = LoginPresenter(viewController: viewController)
		viewController.interactor = LoginInteractor(worker: worker, presenter: presenter)
		return viewController
	}

}


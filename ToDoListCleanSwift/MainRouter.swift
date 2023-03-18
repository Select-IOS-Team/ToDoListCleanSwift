//
//  MainRouter.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//

import Foundation

protocol IMainRouter {
	func routeToTasksViewController()
}

class MainRouter: IMainRouter {
	private var loginViewController: ILoginViewController

	init(loginViewController: ILoginViewController) {
		self.loginViewController = loginViewController
	}

	func routeToTasksViewController() {
		let tasksViewController = TasksDependenciesBuilder.build()
		guard let loginViewController = loginViewController as? LoginViewController else { return }
		navigateToToTasksViewController(source: loginViewController, destination: tasksViewController)
	}

	func navigateToToTasksViewController(source: LoginViewController, destination: TasksViewController) {
		source.show(destination, sender: nil)
	}
}

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

final class MainRouter: IMainRouter {

	// MARK: - Internal properties

	weak var loginViewController: ILoginViewController?

	// MARK: - IMainRouter

	func routeToTasksViewController() {
		let tasksViewController = TasksDependenciesBuilder.build()
		guard let loginViewController = loginViewController as? LoginViewController else { return }
		navigateToToTasksViewController(source: loginViewController, destination: tasksViewController)
	}

	// MARK: - Private methods

	private func navigateToToTasksViewController(source: LoginViewController, destination: TasksViewController) {
		source.show(destination, sender: nil)
	}
}

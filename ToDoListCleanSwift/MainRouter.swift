//////
//////  MainRouter.swift
//////  ToDoListCleanSwift
//////
//////  Created by Evgeni Meleshin on 21.02.2023.
//////

import Foundation

protocol IMainRoutingLogic {
	func routeToSomewhere()
}

class MainRouter: NSObject, IMainRoutingLogic {
	weak var loginViewController: LoginViewController?
	
	func routeToSomewhere() {
		let taskViewController = TasksDependenciesBuilder.build()
		guard let from = loginViewController else { return }
		navigateToSomewhere(source: from, destination: taskViewController)
	}
	
	func navigateToSomewhere(source: LoginViewController, destination: TasksViewController) {
		source.show(destination, sender: nil)
	}
	
}

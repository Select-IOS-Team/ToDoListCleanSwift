//
//  MainRouterSpy.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeniy Novgorodov on 07.04.2023.
//

@testable import ToDoListCleanSwift

final class MainRouterSpy: IMainRouter {

	var invokedRouteToTasksViewController = false
	var invokedRouteToTasksViewControllerCount = 0

	func routeToTasksViewController() {
		invokedRouteToTasksViewController = true
		invokedRouteToTasksViewControllerCount += 1
	}
}

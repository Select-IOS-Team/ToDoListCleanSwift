//
//  TasksViewControllerSpy.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeni Meleshin on 24.03.2023.
//

@testable import ToDoListCleanSwift

final class TasksViewControllerSpy: ITasksViewController {

	// MARK: - Internal properties

	var invokedRender = false
	var invokedRenderCount = 0
	var invokedRenderParameters: (viewData: TaskModel.ViewData, Void)?
	var invokedRenderParametersList = [(viewData: TaskModel.ViewData, Void)]()

	// MARK: - ITasksViewController

	func render(viewData: TaskModel.ViewData) {
		invokedRender = true
		invokedRenderCount += 1
		invokedRenderParameters = (viewData, ())
		invokedRenderParametersList.append((viewData, ()))
	}
}

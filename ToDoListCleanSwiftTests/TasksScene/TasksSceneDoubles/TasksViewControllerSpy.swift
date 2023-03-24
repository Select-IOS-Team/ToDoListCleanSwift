//
//  TasksViewControllerSpy.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeni Meleshin on 24.03.2023.
//

@testable import ToDoListCleanSwift

final class TasksViewControllerSpy: ITasksViewController {

	// MARK: - Internal Properties

	private(set) var renderIsCalled = false

	// MARK: - Internal Methods

	func render(viewData: ToDoListCleanSwift.TaskModel.ViewData) {
		renderIsCalled = true
	}
}

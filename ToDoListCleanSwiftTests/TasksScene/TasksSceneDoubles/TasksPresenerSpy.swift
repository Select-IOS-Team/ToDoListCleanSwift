//
//  TasksPresenerSpy.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeni Meleshin on 23.03.2023.
//

@testable import ToDoListCleanSwift

final class TasksPresenterSpy: ITasksPresenter {

	// MARK: - Internal properties

	private (set) var presentDataIsCalled = false
	var invokedPresentParameters: ToDoListCleanSwift.TaskModel.Response?

	// MARK: - Internal methods

	func presentData(response: ToDoListCleanSwift.TaskModel.Response) {
		presentDataIsCalled = true
		invokedPresentParameters = response
	}
}

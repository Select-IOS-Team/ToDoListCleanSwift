//
//  TasksPresenerSpy.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeni Meleshin on 23.03.2023.
//

@testable import ToDoListCleanSwift

final class TasksPresenterSpy: ITasksPresenter {

	// MARK: - Internal Properties

	private (set) var presentDataIsCalled = false

	// MARK: - Internal Methods

	func presentData(response: ToDoListCleanSwift.TaskModel.Response) {
		presentDataIsCalled = true
	}
}

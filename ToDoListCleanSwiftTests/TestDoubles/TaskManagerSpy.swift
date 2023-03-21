//
//  TaskManagerSpy.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeniy Novgorodov on 15.03.2023.
//

@testable import ToDoListBusinessLogic

final class TaskManagerSpy: ITaskManager {

	var invokedAllTasks = false
	var invokedAllTasksCount = 0
	var stubbedAllTasksResult: [Task] = []

	func allTasks() -> [Task] {
		invokedAllTasks = true
		invokedAllTasksCount += 1
		return stubbedAllTasksResult
	}

	var invokedCompletedTasks = false
	var invokedCompletedTasksCount = 0
	var stubbedCompletedTasksResult: [Task] = []

	func completedTasks() -> [Task] {
		invokedCompletedTasks = true
		invokedCompletedTasksCount += 1
		return stubbedCompletedTasksResult
	}

	var invokedUncompletedTasks = false
	var invokedUncompletedTasksCount = 0
	var stubbedUncompletedTasksResult: [Task] = []

	func uncompletedTasks() -> [Task] {
		invokedUncompletedTasks = true
		invokedUncompletedTasksCount += 1
		return stubbedUncompletedTasksResult
	}

	var invokedAddTasks = false
	var invokedAddTasksCount = 0
	var invokedAddTasksParameters: (tasks: [Task], Void)?
	var invokedAddTasksParametersList = [(tasks: [Task], Void)]()

	func addTasks(tasks: [Task]) {
		invokedAddTasks = true
		invokedAddTasksCount += 1
		invokedAddTasksParameters = (tasks, ())
		invokedAddTasksParametersList.append((tasks, ()))
	}
}

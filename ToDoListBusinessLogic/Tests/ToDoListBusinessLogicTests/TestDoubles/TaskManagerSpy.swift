//
//  TaskManagerSpy.swift
//  ToDoListBusinessLogicTests
//
//  Created by Evgeniy Novgorodov on 24.03.2023.
//

@testable import ToDoListBusinessLogic

final class TaskManagerSpy: ITaskManager {

	// MARK: - Internal properties

	var invokedAllTasks = false
	var invokedAllTasksCount = 0
	var stubbedAllTasksResult: [Task] = []

	var invokedCompletedTasks = false
	var invokedCompletedTasksCount = 0
	var stubbedCompletedTasksResult: [Task] = []

	var invokedUncompletedTasks = false
	var invokedUncompletedTasksCount = 0
	var stubbedUncompletedTasksResult: [Task] = []

	var invokedAddTask = false
	var invokedAddTaskCount = 0
	var invokedAddTaskParameters: (task: Task, Void)?
	var invokedAddTaskParametersList = [(task: Task, Void)]()

	var invokedAddTasks = false
	var invokedAddTasksCount = 0
	var invokedAddTasksParameters: (tasks: [Task], Void)?
	var invokedAddTasksParametersList = [(tasks: [Task], Void)]()

	var invokedRemoveTask = false
	var invokedRemoveTaskCount = 0
	var invokedRemoveTaskParameters: (task: Task, Void)?
	var invokedRemoveTaskParametersList = [(task: Task, Void)]()

	// MARK: - ITaskManager

	func allTasks() -> [Task] {
		invokedAllTasks = true
		invokedAllTasksCount += 1
		return stubbedAllTasksResult
	}

	func completedTasks() -> [Task] {
		invokedCompletedTasks = true
		invokedCompletedTasksCount += 1
		return stubbedCompletedTasksResult
	}

	func uncompletedTasks() -> [Task] {
		invokedUncompletedTasks = true
		invokedUncompletedTasksCount += 1
		return stubbedUncompletedTasksResult
	}

	func addTask(task: Task) {
		invokedAddTask = true
		invokedAddTaskCount += 1
		invokedAddTaskParameters = (task, ())
		invokedAddTaskParametersList.append((task, ()))
	}

	func addTasks(tasks: [Task]) {
		invokedAddTasks = true
		invokedAddTasksCount += 1
		invokedAddTasksParameters = (tasks, ())
		invokedAddTasksParametersList.append((tasks, ()))
	}

	func removeTask(task: Task) {
		invokedRemoveTask = true
		invokedRemoveTaskCount += 1
		invokedRemoveTaskParameters = (task, ())
		invokedRemoveTaskParametersList.append((task, ()))
	}
}

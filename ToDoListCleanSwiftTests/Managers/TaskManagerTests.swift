//
//  TaskManagerTests.swift
//  TaskManagerTest
//
//  Created by Dmitry Serebrov on 12.03.2023.
//

import XCTest
@testable import ToDoListCleanSwift

final class TaskManagerTests: XCTestCase {
	// MARK: - Tests

	// Проверка того, что менеджер после инициализации имеет пустой список задач
	func test_taskListIsEmptyAfterInit() {
		// given
		let sut = TaskManager()
		
		// when
		let tasks = sut.allTasks()

		// then
		XCTAssertTrue(tasks.isEmpty)
	}

	func test_allTasks_shouldBeEqual() {
		// Given
		let sut = TaskManager()
		let tasks = TasksStub.tasks

		// When
		sut.addTasks(tasks: TasksStub.tasks)
		let result = sut.allTasks()

		// Then
		XCTAssertEqual(result, tasks)
	}

	func test_completedTasks_shouldBeEqual() {
		// Given
		let sut = TaskManager()
		let tasks = TasksStub.completedTasks

		// When
		sut.addTasks(tasks: TasksStub.tasks)
		let result = sut.completedTasks()

		// Then
		XCTAssertEqual(result, tasks)
	}

	func test_uncompletedTasks_shouldBeEqual() {
		// Given
		let tasks = TasksStub.uncompletedTasks
		let sut = TaskManager()

		// When
		sut.addTasks(tasks: TasksStub.tasks)
		let result = sut.uncompletedTasks()

		// Then
		XCTAssertEqual(result, tasks)
	}

	func test_addTask_shouldBeEqual() {
		// Given
		let sut = TaskManager()
		var tasks = TasksStub.tasks
		tasks.append(TasksStub.newTask)

		// When
		sut.addTasks(tasks: TasksStub.tasks)
		sut.addTask(task: TasksStub.newTask)
		let result = sut.allTasks()

		// Then
		XCTAssertEqual(result, tasks)
	}

	func test_addTasks_shouldBeEqual() {
		// Given
		let sut = TaskManager()
		var tasks = [Task]()
		tasks.append(contentsOf: TasksStub.tasks)

		// When
		sut.addTasks(tasks: TasksStub.tasks)
		let result = sut.allTasks()

		// Then
		XCTAssertEqual(result, tasks)
	}

	func test_removeTask_shouldBeEqual() {
		// Given
		let sut = TaskManager()
		let tasks = TasksStub.tasksListAfterRemove

		// When
		sut.addTasks(tasks: TasksStub.tasks)
		let removeItem = sut.allTasks()[4]
		sut.removeTask(task: removeItem)
		let result = sut.allTasks()

		// Then
		XCTAssertEqual(result, tasks)
	}

	private enum TasksStub {
		static var tasks = [
			RegularTask(title: "Regular task 1", isCompleted: true),
			RegularTask(title: "Regular task 2"),
			ImportantTask(title: "Important task 1", priority: .high),
			ImportantTask(title: "Important task 2", priority: .medium),
			ImportantTask(title: "Important task 3", priority: .low)
		]

		static var completedTasks = [RegularTask(title: "Regular task 1", isCompleted: true)]

		static var uncompletedTasks = [
			RegularTask(title: "Regular task 2"),
			ImportantTask(title: "Important task 1", priority: .high),
			ImportantTask(title: "Important task 2", priority: .medium),
			ImportantTask(title: "Important task 3", priority: .low)
		]

		static var newTask = RegularTask(title: "new task")

		static var tasksListAfterRemove = [
			RegularTask(title: "Regular task 1", isCompleted: true),
			RegularTask(title: "Regular task 2"),
			ImportantTask(title: "Important task 1", priority: .high),
			ImportantTask(title: "Important task 2", priority: .medium)
		]
	}
}

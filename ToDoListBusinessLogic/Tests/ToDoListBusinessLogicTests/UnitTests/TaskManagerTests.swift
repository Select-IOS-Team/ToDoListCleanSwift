//
//  TaskManagerTests.swift
//  ToDoListBusinessLogicTests
//
//  Created by Dmitry Serebrov on 12.03.2023.
//

import XCTest
@testable import ToDoListBusinessLogic

final class TaskManagerTests: XCTestCase {

	// MARK: - Tests

	// Проверка того, что менеджер после инициализации имеет пустой список задач
	func test_taskListIsEmptyAfterInit() {
		// arrange
		let sut = TaskManager()

		// act
		let tasks = sut.allTasks()

		// assert
		XCTAssertTrue(tasks.isEmpty, "TaskManager после инициализации имеет не пустой список задач")
	}

	// Проверка 
	func test_allTasks_shouldReturnAllTasks() {
		// arrange
		let sut = TaskManager()
		sut.addTasks(tasks: TasksStub.tasks)
		let expectedTasks = TasksStub.tasks

		// act
		let result = sut.allTasks()

		// assert
		XCTAssertEqual(result, expectedTasks, "При получении всех задач получены некорректные данные")
	}

	// Проверка того, что при получении выполненных задач, возвращаются только выполненные задачи
	func test_completedTasks_shouldReturnOnlyCompletedTasks() {
		// arrange
		let sut = TaskManager()
		sut.addTasks(tasks: TasksStub.tasks)
		let expectedTasks = TasksStub.completedTasks

		// act
		let result = sut.completedTasks()

		// assert
		XCTAssertEqual(result, expectedTasks, "При получении выполненных задач получены некорректные данные")
	}

	// Проверка того, что при получении невыполненных задач, возвращаются только невыполненные задачи
	func test_uncompletedTasks_shouldReturnOnlyUncompletedTasks() {
		// arrange
		let sut = TaskManager()
		sut.addTasks(tasks: TasksStub.tasks)
		let expectedTasks = TasksStub.uncompletedTasks

		// act
		let result = sut.uncompletedTasks()

		// assert
		XCTAssertEqual(result, expectedTasks, "При получении невыполненных задач получены некорректные данные")
	}

	// Проверка добавления задачи
	func test_addTask_shouldAddTask() {
		// arrange
		let sut = TaskManager()
		let addingTask = TasksStub.newTask
		let expectedTasks = [addingTask]

		// act
		sut.addTask(task: addingTask)
		let result = sut.allTasks()

		// assert
		XCTAssertEqual(result, expectedTasks, "При вызове метода добавления задачи, задача не была добавлена")
	}

	// Проверка добавления задач
	func test_addTasks_shouldAddTasks() {
		// arrange
		let sut = TaskManager()
		let addingTasks = TasksStub.tasks
		let expectedTasks = addingTasks

		// act
		sut.addTasks(tasks: addingTasks)
		let result = sut.allTasks()

		// assert
		XCTAssertEqual(result, expectedTasks, "При вызове метода добавления задач, задачи не были добавлены")
	}

	// Проверка удаления задачи
	func test_removeTask_shouldRemoveTask() {
		// arrange
		let sut = TaskManager()
		sut.addTasks(tasks: TasksStub.tasks)
		let removingItem = sut.allTasks()[3]
		let expectedTasks = TasksStub.taskListAfterRemoving

		// act
		sut.removeTask(task: removingItem)
		let result = sut.allTasks()

		// assert
		XCTAssertEqual(result, expectedTasks, "При вызове метода удаления задачи, задача не была удалена")
	}
}

// MARK: - TestData

private extension TaskManagerTests {

	enum TasksStub {
		static let tasks = [
			RegularTask(title: "Regular task 1", isCompleted: true),
			RegularTask(title: "Regular task 2"),
			ImportantTask(title: "Important task 1", priority: .high),
			ImportantTask(title: "Important task 2", priority: .medium),
			ImportantTask(title: "Important task 3", priority: .low)
		]

		static let completedTasks = [RegularTask(title: "Regular task 1", isCompleted: true)]

		static let uncompletedTasks = [
			RegularTask(title: "Regular task 2"),
			ImportantTask(title: "Important task 1", priority: .high),
			ImportantTask(title: "Important task 2", priority: .medium),
			ImportantTask(title: "Important task 3", priority: .low)
		]

		static let newTask = RegularTask(title: "New task")

		static let taskListAfterRemoving = [
			RegularTask(title: "Regular task 1", isCompleted: true),
			RegularTask(title: "Regular task 2"),
			ImportantTask(title: "Important task 1", priority: .high),
			ImportantTask(title: "Important task 3", priority: .low)
		]
	}
}

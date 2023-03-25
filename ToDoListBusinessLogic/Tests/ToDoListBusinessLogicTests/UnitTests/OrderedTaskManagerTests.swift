//
//  OrderedTaskManagerTests.swift
//  ToDoListBusinessLogicTests
//
//  Created by Evgeniy Novgorodov on 24.03.2023.
//

import XCTest
@testable import ToDoListBusinessLogic

final class OrderedTaskManagerTests: XCTestCase {

	// MARK: - Private properties

	private var taskManagerSpy: TaskManagerSpy! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: - Tests

	// Проверка того, что при получении всех задач, они имеют правильный порядок
	func test_allTasks_shouldBeRightOrderOfTasks() {
		// arrange
		let sut = makeSut()
		taskManagerSpy.stubbedAllTasksResult = TasksStub.unorderedTasks

		// act
		let tasks = sut.allTasks()

		// assert
		XCTAssertTrue(taskManagerSpy.invokedAllTasks, "Не был вызван метод получения всех задач у TaskManager")
		XCTAssertEqual(tasks, TasksStub.orderedTasks, "Неверный порядок задач при получении всех задач")
	}

	// Проверка того, что при получении выполненных задач, они имеют правильный порядок
	func test_completedTasks_shouldBeRightOrderOfTasks() {
		// arrange
		let sut = makeSut()
		taskManagerSpy.stubbedCompletedTasksResult = TasksStub.unorderedTasks

		// act
		let tasks = sut.completedTasks()

		// assert
		XCTAssertTrue(taskManagerSpy.invokedCompletedTasks, "Не был вызван метод получения выполненных задач у TaskManager")
		XCTAssertEqual(tasks, TasksStub.orderedTasks, "Неверный порядок задач при получении выполненных задач")
	}

	// Проверка того, что при получении невыполненных задач, они имеют правильный порядок
	func test_uncompletedTasks_shouldBeRightOrderOfTasks() {
		// arrange
		let sut = makeSut()
		taskManagerSpy.stubbedUncompletedTasksResult = TasksStub.unorderedTasks

		// act
		let tasks = sut.uncompletedTasks()

		// assert
		XCTAssertTrue(
			taskManagerSpy.invokedUncompletedTasks,
			"Не был вызван метод получения невыполненных задач у TaskManager"
		)
		XCTAssertEqual(tasks, TasksStub.orderedTasks, "Неверный порядок задач при получении невыполненных задач")
	}

	// Проверка добавления задачи
	func test_addTask_shouldAddTask() {
		// arrange
		let sut = makeSut()
		let addingTask = TasksStub.regularTask
		let expectedTasks = [addingTask]

		// act
		sut.addTask(task: addingTask)

		// assert
		XCTAssertTrue(taskManagerSpy.invokedAddTask, "Не был вызван метод добавления задачи у TaskManager")
		XCTAssertEqual(
			taskManagerSpy.invokedAddTaskParameters?.task,
			addingTask,
			"Добавляемая задача не соответствует переданной для добавления"
		)
	}

	// Проверка добавления массива задач
	func test_addTasks_shouldAddTasks() {
		// arrange
		let sut = makeSut()
		let addingTasks = TasksStub.addingTasks

		// act
		sut.addTasks(tasks: addingTasks)

		// assert
		XCTAssertTrue(taskManagerSpy.invokedAddTasks, "Не был вызван метод добавления задач у TaskManager")
		XCTAssertEqual(
			taskManagerSpy.invokedAddTasksParameters?.tasks,
			addingTasks,
			"Добавляемый миссив задач не соответствует переданному для добавления"
		)
	}

	// Проверка удаления задачи
	func test_removeTask_shouldRemoveTask() {
		// arrange
		let sut = makeSut()
		let removingTask = TasksStub.regularTask

		// act
		sut.removeTask(task: removingTask)

		// assert
		XCTAssertTrue(taskManagerSpy.invokedRemoveTask, "Не был вызван метод удаления задачи у TaskManager")
		XCTAssertEqual(
			taskManagerSpy.invokedRemoveTaskParameters?.task,
			removingTask,
			"Удаляемая задача не соответствует переданной для удаления"
		)
	}
}

// MARK: - TestData

private extension OrderedTaskManagerTests {

	enum TasksStub {
		static let unorderedTasks = [
			RegularTask(title: "Regular task 1"),
			RegularTask(title: "Regular task 2"),
			ImportantTask(title: "Important task 1", priority: .high),
			ImportantTask(title: "Important task 3", priority: .medium),
			ImportantTask(title: "Important task 2", priority: .high),
			ImportantTask(title: "Important task 4", priority: .low),
			RegularTask(title: "Regular task 3"),
			ImportantTask(title: "Important Task 5", priority: .low),
			ImportantTask(title: "Important Task 6", priority: .low),
			RegularTask(title: "Regular Task 4"),
			ImportantTask(title: "Important task 7", priority: .medium)
		]

		static let orderedTasks = [
			ImportantTask(title: "Important task 1", priority: .high),
			ImportantTask(title: "Important task 2", priority: .high),
			ImportantTask(title: "Important task 3", priority: .medium),
			ImportantTask(title: "Important task 7", priority: .medium),
			ImportantTask(title: "Important task 4", priority: .low),
			ImportantTask(title: "Important Task 5", priority: .low),
			ImportantTask(title: "Important Task 6", priority: .low),
			RegularTask(title: "Regular Task 4"),
			RegularTask(title: "Regular task 3"),
			RegularTask(title: "Regular task 2"),
			RegularTask(title: "Regular task 1")
		]

		static let regularTask = RegularTask(title: "New task")

		static let addingTasks = [
			ImportantTask(title: "Important Task 8", priority: .low),
			ImportantTask(title: "Important Task 9", priority: .high),
			RegularTask(title: "Regular Task 5")
		]
	}
}

// MARK: - Private

private extension OrderedTaskManagerTests {

	func makeSut() -> OrderedTaskManager {
		taskManagerSpy = TaskManagerSpy()
		return OrderedTaskManager(taskManager: taskManagerSpy)
	}
}

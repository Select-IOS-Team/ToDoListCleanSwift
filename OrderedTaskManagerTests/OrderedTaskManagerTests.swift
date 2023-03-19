//
//  OrderedTaskManagerTests.swift
//  OrderedTaskManagerTests
//
//  Created by Dmitry Serebrov on 19.03.2023.
//

import XCTest
@testable import ToDoListCleanSwift

final class OrderedTaskManagerTests: XCTestCase {

	var sut: OrderedTaskManager?

    override func setUp() {
        super.setUp()
		sut = OrderedTaskManager(taskManager: TaskManager())
    }

    override func tearDown() {
		super.tearDown()
    }

	func test_allTasks_shouldBeEqual() {
		// Given
		let orderedTasks = TasksStub.orderedTasks

		// When
		sut?.addTasks(tasks: TasksStub.unorderedTasks)
		let result = sut?.allTasks()

		// Then
		XCTAssertEqual(result, orderedTasks)
	}

	func test_completedTasks_shouldBeEqual() {
		// Given
		let tasks = TasksStub.completedTasks

		// When
		sut?.addTasks(tasks: TasksStub.unorderedTasks)
		let result = sut?.completedTasks()

		// Then
		XCTAssertEqual(result, tasks)
	}

	func test_uncompletedTasks_shouldBeEqual() {
		// Given
		let tasks = TasksStub.uncompletedTasks

		// When
		sut?.addTasks(tasks: TasksStub.unorderedTasks)
		let result = sut?.uncompletedTasks()

		// Then
		XCTAssertEqual(result, tasks)
	}

	func test_addTasks_shouldBeEqual() {
		// Given
		var tasks = [Task]()
		tasks.append(contentsOf: TasksStub.tasksAfterAddition)

		// When
		sut?.addTasks(tasks: TasksStub.unorderedTasks)
		sut?.addTasks(tasks: TasksStub.tasksToAdd)
		let result = sut?.allTasks()

		// Then
		XCTAssertEqual(result, tasks)
	}

	private enum TasksStub {
		static var unorderedTasks = [
			RegularTask(title: "Regular task 1", completed: true),
			RegularTask(title: "Regular task 2"),
			ImportantTask(title: "Important task 1", priority: .high),
			ImportantTask(title: "Important task 3", priority: .medium),
			ImportantTask(title: "Important task 2", priority: .high),
			ImportantTask(title: "Important task 4", priority: .low),
			RegularTask(title: "Regular task 3"),
			ImportantTask(title: "Important Task 5", priority: .low),
			ImportantTask(title: "Important Task 6", priority: .low, completed: true),
			RegularTask(title: "Regular Task 4", completed: true),
			ImportantTask(title: "Important task 7", priority: .medium, completed: true)
		]

		static var orderedTasks = [
			ImportantTask(title: "Important task 1", priority: .high),
			ImportantTask(title: "Important task 2", priority: .high),
			ImportantTask(title: "Important task 3", priority: .medium),
			ImportantTask(title: "Important task 7", priority: .medium, completed: true),
			ImportantTask(title: "Important task 4", priority: .low),
			ImportantTask(title: "Important Task 5", priority: .low),
			ImportantTask(title: "Important Task 6", priority: .low, completed: true),
			RegularTask(title: "Regular Task 4", completed: true),
			RegularTask(title: "Regular task 3"),
			RegularTask(title: "Regular task 2"),
			RegularTask(title: "Regular task 1", completed: true)
		]

		static var completedTasks = [
			ImportantTask(title: "Important task 7", priority: .medium, completed: true),
			ImportantTask(title: "Important Task 6", priority: .low, completed: true),
			RegularTask(title: "Regular Task 4", completed: true),
			RegularTask(title: "Regular task 1", completed: true)
		]

		static var uncompletedTasks = [
			ImportantTask(title: "Important task 1", priority: .high),
			ImportantTask(title: "Important task 2", priority: .high),
			ImportantTask(title: "Important task 3", priority: .medium),
			ImportantTask(title: "Important task 4", priority: .low),
			ImportantTask(title: "Important Task 5", priority: .low),
			RegularTask(title: "Regular task 3"),
			RegularTask(title: "Regular task 2")
		]

		static var tasksToAdd = [
			ImportantTask(title: "Important Task 8", priority: .low),
			ImportantTask(title: "Important Task 9", priority: .high),
			RegularTask(title: "Regular Task 5")
		]

		static var tasksAfterAddition = [
			ImportantTask(title: "Important task 1", priority: .high),
			ImportantTask(title: "Important task 2", priority: .high),
			ImportantTask(title: "Important Task 9", priority: .high),
			ImportantTask(title: "Important task 3", priority: .medium),
			ImportantTask(title: "Important task 7", priority: .medium, completed: true),
			ImportantTask(title: "Important task 4", priority: .low),
			ImportantTask(title: "Important Task 5", priority: .low),
			ImportantTask(title: "Important Task 6", priority: .low, completed: true),
			ImportantTask(title: "Important Task 8", priority: .low),
			RegularTask(title: "Regular Task 5"),
			RegularTask(title: "Regular Task 4", completed: true),
			RegularTask(title: "Regular task 3"),
			RegularTask(title: "Regular task 2"),
			RegularTask(title: "Regular task 1", completed: true)
		]
	}
}

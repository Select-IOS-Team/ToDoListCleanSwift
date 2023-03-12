//
//  TaskManagerTest.swift
//  TaskManagerTest
//
//  Created by Dmitry Serebrov on 12.03.2023.
//

import XCTest
@testable import ToDoListCleanSwift

final class TaskManagerTest: XCTestCase {
	
	var sut: TaskManager!

    override func setUpWithError() throws {
        sut = TaskManager()
		let repository = Repository()
		sut.addTasks(tasks: repository.getAllTasks())
    }

    override func tearDownWithError() throws {
		sut = nil
    }
	
	func test_allTasks_shouldBeEqual() {
		// Given
		let tasks = TasksStub.tasks

		// When
		let result = sut.allTasks()

		// Then
		XCTAssertEqual(result, tasks)
	}

	func test_completedTasks_shouldBeEqual() {
		// Given
		let tasks = TasksStub.completedTasks

		// When
		let result = sut.completedTasks()

		// Then
		XCTAssertEqual(result, tasks)
	}

	func test_uncompletedTasks_shouldBeEqual() {
		// Given
		let tasks = TasksStub.uncompletedTasks

		// When
		let result = sut.uncompletedTasks()

		// Then
		XCTAssertEqual(result, tasks)

	}

	func test_addTask_shouldBeEqual() {
		// Given
		var tasks = TasksStub.tasks
		tasks.append(TasksStub.newTask)

		// When
		sut.addTask(task: TasksStub.newTask)
		let result = sut.allTasks()

		// Then
		XCTAssertEqual(result, tasks)
	}

	func test_addTasks_shouldBeEqual() {
		// Given
		var tasks = TasksStub.tasks
		tasks.append(contentsOf: [TasksStub.newTask])

		// When
		sut.addTasks(tasks: [TasksStub.newTask])
		let result = sut.allTasks()

		// Then
		XCTAssertEqual(result, tasks)
	}

	func test_removeTask_shouldBeEqual() {
		// Given
		let tasks = TasksStub.tasksListAfterRemove

		// When
		let removeItem = sut.allTasks()[4]
		sut.removeTask(task: removeItem)
		let result = sut.allTasks()

		// Then
		XCTAssertEqual(result, tasks)
	}
	
	enum TasksStub {
		static var tasks = [RegularTask(title: "Regular task 1"),
							RegularTask(title: "Regular task 2"),
							ImportantTask(title: "Important task 1", priority: .high),
							ImportantTask(title: "Important task 2", priority: .medium),
							ImportantTask(title: "Important task 3", priority: .low)]
		
		static var completedTasks = [Task]()
		
		static var uncompletedTasks = [RegularTask(title: "Regular task 1"),
									   RegularTask(title: "Regular task 2"),
									   ImportantTask(title: "Important task 1", priority: .high),
									   ImportantTask(title: "Important task 2", priority: .medium),
									   ImportantTask(title: "Important task 3", priority: .low)]
		
		static var newTask = RegularTask(title: "new task")
		
		static var tasksListAfterRemove = [RegularTask(title: "Regular task 1"),
										   RegularTask(title: "Regular task 2"),
										   ImportantTask(title: "Important task 1", priority: .high),
										   ImportantTask(title: "Important task 2", priority: .medium)]
	}
}

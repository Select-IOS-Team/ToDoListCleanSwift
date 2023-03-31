//
//  RepositoryTests.swift
//  ToDoListCleanSwiftTests
//
//  Created by SERGEY SHLYAKHIN on 22.03.2023.
//

import XCTest
import ToDoListBusinessLogic
@testable import ToDoListCleanSwift

final class RepositoryTests: XCTestCase {

	final class RepositoryMock: IRepository {
		private let tasks: [Task]

		init(tasks: [Task]) {
			self.tasks = tasks
		}

		func getAllTasks() -> [Task] {
			tasks
		}
	}

	func test_getAllTasksAmountAndContain_shouldBeNineAndAllTasksContains() {
		// arrange
		let sut = Repository()

		// act
		let tasks = sut.getAllTasks()

		// assert
		XCTAssertEqual(tasks.count, 9, "Записей не 9")

		XCTAssertTrue(
			tasks.contains(where: { $0.title == "To clean the room" }),
			"Нет записи с заголовком: To clean the room"
		)
		XCTAssertTrue(
			tasks.contains(where: { $0.title == "Learning English" }),
			"Нет записи с заголовком: Learning English"
		)
		XCTAssertTrue(
			tasks.contains(where: { $0.title == "Walk" }),
			"Нет записи с заголовком: Walk"
		)
		XCTAssertTrue(
			tasks.contains(where: { $0.title == "To wash the dishes" }),
			"Нет записи с заголовком: To wash the dishes"
		)
		XCTAssertTrue(
			tasks.contains(where: { $0.title == "Workout" }),
			"Нет записи с заголовком: Workout"
		)
		XCTAssertTrue(
			tasks.contains(where: { $0.title == "To fix shoes" }),
			"Нет записи с заголовком: To fix shoes"
		)
		XCTAssertTrue(
			tasks.contains(where: { $0.title == "Homework" }),
			"Нет записи с заголовком: Homework"
		)
		XCTAssertTrue(
			tasks.contains(where: { $0.title == "Relax" }),
			"Нет записи с заголовком: Relax"
		)
		XCTAssertTrue(
			tasks.contains(where: { $0.title == "To bake coockies and three cakes (for two lines in title)" }),
			"Нет записи с заголовком: To bake coockies and three cakes (for two lines in title)"
		)
	}

	func test_mockRepositoryGetAllTasks_WithCustomTasks_shouldBeTwoAndAllTasksContains() {
		// arrange
		let task1 = Task(title: "Task 1")
		let task2 = Task(title: "Task 2")

		let sut = RepositoryMock(tasks: [task1, task2])

		// act
		let tasks = sut.getAllTasks()

		// assert
		XCTAssertEqual(tasks.count, 2, "Задач не 2")
		XCTAssertTrue(tasks.contains(task1), "Задача 1 отсутствует")
		XCTAssertTrue(tasks.contains(task2), "Задача 2 отсутствует")
	}
}

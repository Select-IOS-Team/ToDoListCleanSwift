//
//  ImportantTaskTests.swift
//  ToDoListBusinessLogicTests
//
//  Created by Evgeni Meleshin on 10.03.2023.
//

import Foundation
import XCTest
@testable import ToDoListBusinessLogic

/// Класс тестов для важной задачи
final class ImportantTaskTests: XCTestCase {
	// После создания задачи с высоким приоритетом, дата ее выполнения должна быть равна текущей + 1 день
	func test_completionDate_withHighPriority_shouldBeEqualCurrentDatePlusOneDay() {

		// arrange
		let sut = ImportantTask(title: "Important task with high priority", priority: .high)

		// act
		let differenceDays = calculateDifference(task: sut, daysCount: 1)

		// assert
		XCTAssertEqual(
			differenceDays,
			1,
			"Completion date for important task with high priority should be current date + 1 day"
		)
	}
	// После создания задачи со средним приоритетом, дата ее выполнения должна быть равна текущей + 2 дня
	func test_completionDate_withMediumPriority_shouldBeEqualCurrentDatePlusTwoDays() {

		// arrange
		let sut = ImportantTask(title: "Important task with medium priority", priority: .medium)

		// act
		let differenceDays = calculateDifference(task: sut, daysCount: 2)

		// assert
		XCTAssertEqual(
			differenceDays,
			2,
			"Completion date for important task with medium priority should be current date + 2 days"
		)
	}

	// После создания задачи с низким приоритетом, дата ее выполнения должна быть равна текущей + 3 дня
	func test_completionDate_withLowPriority_shouldBeEqualCurrentDatePlusThreeDays() {

		// arrange
		let sut = ImportantTask(title: "Important task with low priority", priority: .low)

		// act
		let differenceDays = calculateDifference(task: sut, daysCount: 3)

		// assert
		XCTAssertEqual(
			differenceDays,
			3,
			"Completion date for important task with low priority should be current date + 3 days"
		)
	}
}

private extension ImportantTaskTests {
	func calculateDifference(task: ImportantTask, daysCount: Int) -> Int {
		let completionDate = task.completionDate
		let differenceSeconds = Date().distance(to: completionDate)
		return Int(round(differenceSeconds / 60 / 60 / 24))
	}
}

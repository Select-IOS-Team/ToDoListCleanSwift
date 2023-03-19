//
//  ImportantTaskTests.swift
//  ImportantTaskTests
//
//  Created by Evgeni Meleshin on 10.03.2023.
//

import Foundation
import XCTest
@testable import ToDoListBusinessLogic

/// Класс тестов для важной задачи
final class ImportantTaskTests: XCTestCase {

	// Различие м-ду датой выполнения и текущей должно быть в dayCountForCompletion по приоритету
	func test_importantTask_DifferenceShouldBeEqualDayCount() {
		ImportantTask.Priority.allCases.forEach { priority in
			// arrange
			let sut = ImportantTask(title: "Important task example", priority: priority)

			// act
			let completionDate = sut.completionDate
			let differenceSeconds = Date().distance(to: completionDate)
			let differenceDays = Int(round(differenceSeconds / 60 / 60 / 24))

			// assert
			XCTAssertEqual(
				differenceDays,
				priority.dayCountForCompletion,
				"Difference for \(priority) should be \(priority.dayCountForCompletion)"
			)
		}
	}
}

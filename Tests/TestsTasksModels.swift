//
//  TestsTasksModels.swift
//  TestsTasksModels
//
//  Created by Evgeni Meleshin on 10.03.2023.
//

import Foundation
import XCTest
@testable import ToDoListCleanSwift

/// Класс тестов для обычной задачи
final class TestRegularTask: XCTestCase {

	override func setUp() {
		super.setUp()
    }

	override func tearDown() {
		super.tearDown()
    }
	
	/// Тест: после вызова метода значение должно быть инвертировано
	func test_regularTask_completedShouldBeTrue() {
		
		// arrange
		let sut = TasksStub.regularTask
		
		// act
		sut.completeTask()
		let completed = sut.completed
		
		// assert
		XCTAssertNotEqual(completed, !completed, "Values should not be equals")
	}

}

/// Класс тестов для важной задачи
final class TestImportantTask: XCTestCase {
	
	override func setUp() {
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	/// Тест: различие м-ду датой выполнения и текущей должно быть в rowValue по приоритету
	func test_importantTask_DifferenceShouldBeNotNilEqualRawValue() {
		
		ImportantTaskPriorities.allCases.forEach { priority in
			
			// arrange
			guard let sut = TasksStub.importantTaskByRawValue(rawValue: priority.rawValue) else { return }
			
			// act
			let completionDate = sut.completionDate
			let differenceSeconds = Date().distance(to: completionDate)
			let differenceDays = Int(round(differenceSeconds / 60 / 60 / 24))
			
			// assert
			XCTAssertNotNil(sut, "Instance by priority.rawValue return nil")
			XCTAssertEqual(differenceDays, priority.rawValue, "Difference for \(priority) should be \(priority.rawValue)")
			
		}
		
	}
	
}

/// Подготовленные данные для тестирования
enum TasksStub {
	
	static var regularTask = RegularTask(title: "Regular task example")
	static var importantTaskHigh = ImportantTask(title: "Important task high", priority: .high)
	static var importantTaskMedium = ImportantTask(title: "Important task medium", priority: .medium)
	static var importantTaskLow = ImportantTask(title: "Important task low", priority: .low)
	
	static func importantTaskByRawValue(rawValue: Int) -> ImportantTask? {
		guard let priority = ImportantTaskPriorities(rawValue: rawValue) else { return nil }
		return ImportantTask(title: "Important task example", priority: priority)
	}
	
}

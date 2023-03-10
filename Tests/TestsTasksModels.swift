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

	func test_regularTask_titleShouldBeFilled() {
		
		// arrange
		let sut = TasksStub.regularTask
		
		// act
		let title = sut.title
		
		// assert
		XCTAssertEqual(title, sut.title, "Values should be equals")
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
	func test_importantTask_withLowPriority_completionDateAsDifferenceLow() {
		
		// arrange
		let sut = TasksStub.importantTaskLow
		
		// act
		let completionDate = sut.completionDate
		let differenceSeconds = Date().distance(to: completionDate)
		let differenceDays = Int(round(differenceSeconds / 60 / 60 / 24))
		
		// assert
		XCTAssertEqual(differenceDays, ImportantTaskPriorities.low.rawValue, "Values should be equals")
	}
	
}

/// Подготовленные данные для тестирования
enum TasksStub {
	
	static var regularTask = RegularTask(title: "Regular task example")
	static var importantTaskHigh = ImportantTask(title: "Important task high", priority: .high)
	static var importantTaskMedium = ImportantTask(title: "Important task medium", priority: .medium)
	static var importantTaskLow = ImportantTask(title: "Important task low", priority: .low)
	
}

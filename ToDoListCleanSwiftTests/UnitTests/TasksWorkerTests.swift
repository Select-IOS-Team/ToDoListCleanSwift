//
//  TasksWorkerTests.swift
//  TasksWorkerTests
//
//  Created by Evgeni Meleshin on 20.03.2023.
//

import XCTest
import ToDoListBusinessLogic
@testable import ToDoListCleanSwift

/// Класс тестирует методы worker
final class TasksWorkerTests: XCTestCase {

	// MARK: - Internal Methods

	// Проверка что метод fillResponse вызывается
	func test_fillResponse_withResult_shouldBeCalled() {

		// arrange
		let sut = TasksWorker()
		let result = [(section: SectionsTypes.completedTasks, tasks: [RegularTask(title: "Regular task")])]
		let data = TaskModel.ResponseData(sectionType: .completedTasks, sectionTasks: [RegularTask(title: "Regular task")])
		let expectedResult = TaskModel.Response(data: [data])

		// act
		let response = sut.fillResponse(result: result)

		// assert
		XCTAssertEqual(response.data, expectedResult.data, "Не был вызван требуемый метод fillResponse()")
	}
}

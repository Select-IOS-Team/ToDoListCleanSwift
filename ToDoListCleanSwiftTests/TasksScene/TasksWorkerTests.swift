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

	// MARK: - Internal methods

	// Проверка соответствия структуры TaskModel.Response на основе переданных данных
	func test_fillResponse_withResult_shouldBeMatchPreparedData() {

		// arrange
		let sut = TasksWorker()
		let data = prepareStub()
		let expectedResult = prepareExpectedResult()

		// act
		let response = sut.convertToTaskModelResponse(data: data)

		// assert
		XCTAssertEqual(
			response.data[0].sectionType,
			SectionType.uncompletedTasks,
			"Первой секцией в списке должны быть невыполненные задачи"
		)

		XCTAssertEqual(
			response.data[1].sectionType,
			SectionType.completedTasks,
			"Второй секцией в списке должны быть выполненные задачи"
		)
		XCTAssertEqual(response.data[0].sectionTasks.count, 1, "Первая секция должна содержать 1 задачу")
		XCTAssertEqual(response.data[1].sectionTasks.count, 2, "Вторая секция должна содержать 2 задачи")
		XCTAssertEqual(response.data, expectedResult.data, "Структура TaskModel.Response не соответствует переданным данным")
	}
}

// MARK: - Private methods
private extension TasksWorkerTests {
	private func prepareStub() -> [(SectionType, [Task])] {
		let importantTask1 = ImportantTask(title: "Important task 1", priority: .high)
		let importantTask2 = ImportantTask(title: "Important task 2", priority: .low)
		return [
			(section: SectionType.uncompletedTasks, tasks: [RegularTask(title: "Regular task")]),
			(section: SectionType.completedTasks, tasks: [importantTask1, importantTask2])
		]
	}
	private func prepareExpectedResult() -> TaskModel.Response {
		let importantTask1 = ImportantTask(title: "Important task 1", priority: .high)
		let importantTask2 = ImportantTask(title: "Important task 2", priority: .low)
		let dataUncompletedTasks = TaskModel.ResponseData(
			sectionType: .uncompletedTasks, sectionTasks: [RegularTask(title: "Regular task")]
		)
		let dataCompletedTasks = TaskModel.ResponseData(
			sectionType: .completedTasks, sectionTasks: [importantTask1, importantTask2]
		)
		return TaskModel.Response(data: [dataUncompletedTasks, dataCompletedTasks])
	}
}

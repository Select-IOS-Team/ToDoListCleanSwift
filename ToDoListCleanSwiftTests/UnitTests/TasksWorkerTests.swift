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

	// Проверка соответствия структуры TaskModel.Response на основе переданных данных
	func test_fillResponse_withResult_shouldBeMatchPreparedData() {

		// arrange
		let sut = TasksWorker()
		let result = prepareStub()
		let expectedResult = prepareExpectedResult()

		// act
		let response = sut.fillResponse(result: result)
		// swiftlint: disable: force_cast
		let firstImportantTask = response.data[1].sectionTasks[0] as! ImportantTask
		let secondImportantTask = response.data[1].sectionTasks[1] as! ImportantTask
		// swiftlint: enable: force_cast
		// swiftlint: disable: force_unwrapping
		let indexFirstImportantTask = response.data[1].sectionTasks.firstIndex(of: firstImportantTask)!
		let indexSecondImportantTask = response.data[1].sectionTasks.firstIndex(of: secondImportantTask)!
		// swiftlint: enable: force_unwrapping

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
		XCTAssertLessThan(
			indexFirstImportantTask,
			indexSecondImportantTask,
			"Задача с приоритетом high должна быть быть выше задачи с приоритетом low"
		)
		XCTAssertEqual(response.data, expectedResult.data, "Структура TaskModel.Response не соответствует переданным данным")
	}
}

// MARK: - Private Methods
private extension TasksWorkerTests {
	private func prepareStub() -> [(SectionType, [Task])] {
		let importantTask1 = ImportantTask(title: "Important task 1", priority: .high)
			importantTask1.toggleCompletetionState()
		let importantTask2 = ImportantTask(title: "Important task 2", priority: .low)
			importantTask2.toggleCompletetionState()
		return [
			(section: SectionType.uncompletedTasks, tasks: [RegularTask(title: "Regular task")]),
			(section: SectionType.completedTasks, tasks: [importantTask1, importantTask2])
		]
	}
	private func prepareExpectedResult() -> TaskModel.Response {
		let importantTask1 = ImportantTask(title: "Important task 1", priority: .high)
			importantTask1.toggleCompletetionState()
		let importantTask2 = ImportantTask(title: "Important task 2", priority: .low)
			importantTask2.toggleCompletetionState()
		let dataUncompletedTasks = TaskModel.ResponseData(
			sectionType: .uncompletedTasks, sectionTasks: [RegularTask(title: "Regular task")]
		)
		let dataCompletedTasks = TaskModel.ResponseData(
			sectionType: .completedTasks, sectionTasks: [importantTask1, importantTask2]
		)
		return TaskModel.Response(data: [dataUncompletedTasks, dataCompletedTasks])
	}
}

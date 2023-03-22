//
//  SectionAdapterTests.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeniy Novgorodov on 15.03.2023.
//

import XCTest
import ToDoListBusinessLogic
@testable import ToDoListCleanSwift

final class SectionAdapterTests: XCTestCase {

	// MARK: - Private properties

	private var taskManagerSpy: TaskManagerSpy! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: - Tests

	// Проверка получаемых типов секций
	func test_getSectionsTypes_sectionsTypesAreExpected() {
		// arrange
		let sut = makeSut()
		let expectedSectionsTypes: [SectionsTypes] = [.uncompletedTasks, .completedTasks]

		// act
		let sectionsTypes = sut.getSectionsTypes()

		// assert
		XCTAssertEqual(sectionsTypes, expectedSectionsTypes, "Полученные типы секций не соответствуют ожидаемому результату")
	}

	// Проверка того, что у TaskManager'а запрашиваются выполненные задачи при получении задач для секции выполненных задач
	func test_getTasksForSectionsType_withSectionTypeIsCompletedTasks_shouldInvokeCompletedTasks() {
		// arrange
		let sut = makeSut()
		let expectedTasks = [RegularTask(title: "Regular task 1", isCompleted: true)]
		taskManagerSpy.stubbedCompletedTasksResult = expectedTasks

		// act
		let tasks = sut.getTasksForSectionsType(sectionType: .completedTasks)

		// assert
		XCTAssertTrue(taskManagerSpy.invokedCompletedTasks, "Не был вызван требуемый вызова метод completedTasks()")
		XCTAssertFalse(taskManagerSpy.invokedUncompletedTasks, "Вызван не требуемый вызова метод uncompletedTasks()")
		XCTAssertEqual(tasks, expectedTasks, "Полученные задачи не соответствуют ожидаемым")
	}

	// Проверка того, что у TaskManager'а запрашиваются невыполненные задачи при получении задач
	// для секции невыполненных задач
	func test_getTasksForSectionsType_withSectionTypeIsUncompletedTasks_shouldInvokeUncompletedTasks() {
		// arrange
		let sut = makeSut()
		let expectedTasks = [
			RegularTask(title: "Regular task 2"),
			ImportantTask(title: "Important task 1", priority: .high)
		]
		taskManagerSpy.stubbedUncompletedTasksResult = expectedTasks

		// act
		let tasks = sut.getTasksForSectionsType(sectionType: .uncompletedTasks)

		// assert
		XCTAssertTrue(taskManagerSpy.invokedUncompletedTasks, "Не был вызван требуемый вызова метод uncompletedTasks()")
		XCTAssertFalse(taskManagerSpy.invokedCompletedTasks, "Вызван не требуемый вызова метод completedTasks()")
		XCTAssertEqual(tasks, expectedTasks, "Полученные задачи не соответствуют ожидаемым")
	}

	// Проверка того, что возвращается верный индекс если искомая задача присутствует
	func test_getSectionTypeAndIndex_withTargetTask_shouldReturnCorrectSectionTypeAndIndex() {
		// arrange
		let sut = makeSut()
		let task = ImportantTask(title: "Important task 3", priority: .medium)

		taskManagerSpy.stubbedCompletedTasksResult = [RegularTask(title: "Regular task 1", isCompleted: true)]
		taskManagerSpy.stubbedUncompletedTasksResult = [
			RegularTask(title: "Regular task 2"),
			ImportantTask(title: "Important task 1", priority: .high),
			task
		]

		// act
		let sectionTypeAndIndex = sut.getSectionTypeAndIndex(task: task)

		// assert
		XCTAssertEqual(
			sectionTypeAndIndex?.sectionType,
			.uncompletedTasks,
			"Полученный тип секции не соответствует ожидаемому"
		)
		XCTAssertEqual(sectionTypeAndIndex?.index, 2, "Полученный индекс задачи не соответствует ожидаемому")
	}

	// Проверка того, что возвращается nil если искомая задача отсутствует
	func test_getSectionTypeAndIndex_withoutTargetTask_shouldReturnNil() {
		// arrange
		let sut = makeSut()
		let task = ImportantTask(title: "Important task 3", priority: .medium)

		// act
		let sectionTypeAndIndex = sut.getSectionTypeAndIndex(task: task)

		// assert
		XCTAssertTrue(taskManagerSpy.invokedUncompletedTasks, "Не был вызван требуемый вызова метод uncompletedTasks()")
		XCTAssertTrue(taskManagerSpy.invokedCompletedTasks, "Не был вызван требуемый вызова метод completedTasks()")
		XCTAssertNil(sectionTypeAndIndex, "Полученное значение типа секции и индекса не соответствует ожидаемому (nil)")
	}

	// Проверка того, что возвращаемый индекс для секции невыполненных задач равен 0
	func test_getSectionTypeIndex_withSectionTypeIsUncompletedTasks_shouldEqualZero() {
		// arrange
		let sut = makeSut()
		let sectionType = SectionsTypes.uncompletedTasks

		// act
		let sectionTypeIndex = sut.getSectionTypeIndex(sectionType: sectionType)

		// assert
		XCTAssertEqual(sectionTypeIndex, 0, "Полученный индекс секции не соответствует ожидаемому (0)")
	}

	// Проверка того, что возвращаемый индекс для секции выполненных задач равен 1
	func test_getSectionTypeIndex_withSectionTypeIsCompletedTasks_shouldEqualOne() {
		// arrange
		let sut = makeSut()
		let sectionType = SectionsTypes.completedTasks

		// act
		let sectionTypeIndex = sut.getSectionTypeIndex(sectionType: sectionType)

		// assert
		XCTAssertEqual(sectionTypeIndex, 1, "Полученный индекс секции не соответствует ожидаемому (1)")
	}

	// Проверка того, что возвращаемый тип секции для индекса 0 - невыполненные задачи
	func test_getSectionType_withIndexIsZero_shouldEqualUncompletedTasks() {
		// arrange
		let sut = makeSut()

		// act
		let sectionType = sut.getSectionType(index: 0)

		// assert
		XCTAssertEqual(sectionType, .uncompletedTasks, "Полученный тип секции не соответствует ожидаемому (uncompletedTasks)")
	}

	// Проверка того, что возвращаемый тип секции для индекса 1 - выполненные задачи
	func test_getSectionType_withIndexIsOne_shouldEqualCompletedTasks() {
		// arrange
		let sut = makeSut()

		// act
		let sectionType = sut.getSectionType(index: 1)

		// assert
		XCTAssertEqual(sectionType, .completedTasks, "Полученный тип секции не соответствует ожидаемому (completedTasks)")
	}
}

// MARK: - Private methods

private extension SectionAdapterTests {

	func makeSut() -> SectionAdapter {
		taskManagerSpy = TaskManagerSpy()
		return SectionAdapter(taskManager: taskManagerSpy)
	}
}

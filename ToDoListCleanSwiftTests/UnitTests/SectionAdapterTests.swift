//
//  SectionAdapterTests.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeniy Novgorodov on 15.03.2023.
//

import XCTest
import ToDoListBusinessLogic
@testable import ToDoListCleanSwift

// swiftlint:disable implicitly_unwrapped_optional

final class SectionAdapterTests: XCTestCase {

	// MARK: - Private properties

	private var taskManagerMock: TaskManagerMock!

	// MARK: - Tests

	// Проверка получаемых типов секций
	func test_getSectionsTypes_isExpected() {
		// given
		let sut = makeSut()
		let expectedSectionsTypes: [SectionsTypes] = [.uncompletedTasks, .completedTasks]

		// when
		let sectionsTypes = sut.getSectionsTypes()

		// then
		XCTAssertEqual(sectionsTypes, expectedSectionsTypes, "Типы секций не соответствуют ожидаемым")
	}

	// Проверка того, что получаются выполненные задачи при запросе для секции выполненных задач
	func test_getTasksForSectionsType_withSectionTypeIsCompletedTasks_shouldGetCompletedTasks() {
		// given
		let sut = makeSut()
		let expectedTasks = [RegularTask(title: "Regular task 1", isCompleted: true)]
		taskManagerMock.stubbedCompletedTasksResult = expectedTasks

		// when
		let tasks = sut.getTasksForSectionsType(sectionType: .completedTasks)

		// then
		XCTAssertTrue(taskManagerMock.invokedCompletedTasks, "Не был вызван требуемый вызова метод")
		XCTAssertFalse(taskManagerMock.invokedUncompletedTasks, "Вызван не требуемый вызова метод")
		XCTAssertEqual(tasks, expectedTasks, "Полученные задачи не соответствуют ожидаемым")
	}

	// Проверка того, что получаются невыполненные задачи при запросе для секции невыполненных задач
	func test_getTasksForSectionsType_withSectionTypeIsUncompletedTasks_shouldGetUncompletedTasks() {
		// given
		let sut = makeSut()
		let expectedTasks = [
			RegularTask(title: "Regular task 2"),
			ImportantTask(title: "Important task 1", priority: .high)
		]
		taskManagerMock.stubbedUncompletedTasksResult = expectedTasks

		// when
		let tasks = sut.getTasksForSectionsType(sectionType: .uncompletedTasks)

		// then
		XCTAssertTrue(taskManagerMock.invokedUncompletedTasks, "Не был вызван требуемый вызова метод")
		XCTAssertFalse(taskManagerMock.invokedCompletedTasks, "Вызван не требуемый вызова метод")
		XCTAssertEqual(tasks, expectedTasks, "Полученные задачи не соответствуют ожидаемым")
	}

	// Проверка того, что возвращается верный индекс если искомая задача присутствует
	func test_getSectionTypeAndIndex_withTargetTask_shouldReturnCorrectSectionTypeAndIndex () {
		// given
		let sut = makeSut()
		let task = ImportantTask(title: "Important task 3", priority: .medium)

		taskManagerMock.stubbedCompletedTasksResult = [RegularTask(title: "Regular task 1", isCompleted: true)]
		taskManagerMock.stubbedUncompletedTasksResult = [
			RegularTask(title: "Regular task 2"),
			ImportantTask(title: "Important task 1", priority: .high),
			task
		]

		// when
		let sectionTypeAndIndex = sut.getSectionTypeAndIndex(task: task)

		// then
		XCTAssertEqual(
			sectionTypeAndIndex?.sectionType,
			.uncompletedTasks,
			"Полученный тип секции не соответствует ожидаемому"
		)
		XCTAssertEqual(sectionTypeAndIndex?.index, 2, "Полученный индекс задачи не соответствует ожидаемому")
	}

	// Проверка того, что возвращается nil если искомая задача отсутствует
	func test_getSectionTypeAndIndex_withoutTargetTask_shouldReturnCorrectSectionTypeAndIndex() {
		// given
		let sut = makeSut()
		let task = ImportantTask(title: "Important task 3", priority: .medium)

		// when
		let sectionTypeAndIndex = sut.getSectionTypeAndIndex(task: task)

		// then
		XCTAssertTrue(taskManagerMock.invokedUncompletedTasks, "Не был вызван требуемый вызова метод")
		XCTAssertTrue(taskManagerMock.invokedCompletedTasks, "Не был вызван требуемый вызова метод")
		XCTAssertNil(sectionTypeAndIndex)
	}

	// Проверка того, что возвращаемый индекс для секции невыполненных задач равен 0
	func test_getSectionTypeIndex_withSectionTypeIsUncompletedTasks_shouldEqualZero() {
		// given
		let sut = makeSut()
		let sectionType = SectionsTypes.uncompletedTasks

		// when
		let sectionTypeIndex = sut.getSectionTypeIndex(sectionType: sectionType)

		// then
		XCTAssertEqual(sectionTypeIndex, 0, "Полученный индекс секции не соответствует ожидаемому")
	}

	// Проверка того, что возвращаемый индекс для секции выполненных задач равен 1
	func test_getSectionTypeIndex_withSectionTypeIsCompletedTasks_shouldEqualOne() {
		// given
		let sut = makeSut()
		let sectionType = SectionsTypes.completedTasks

		// when
		let sectionTypeIndex = sut.getSectionTypeIndex(sectionType: sectionType)

		// then
		XCTAssertEqual(sectionTypeIndex, 1, "Полученный индекс секции не соответствует ожидаемому")
	}

	// Проверка того, что возвращаемый тип секции для индекса 0 - невыполненные задачи
	func test_getSectionType_withIndexIsZero_shouldEqualUncompletedTasks() {
		// given
		let sut = makeSut()

		// when
		let sectionType = sut.getSectionType(index: 0)

		// then
		XCTAssertEqual(sectionType, .uncompletedTasks, "Полученный тип секции не соответствует ожидаемому")
	}

	// Проверка того, что возвращаемый тип секции для индекса 1 - выполненные задачи
	func test_getSectionType_withIndexIsOne_shouldEqualCompletedTasks() {
		// given
		let sut = makeSut()

		// when
		let sectionType = sut.getSectionType(index: 1)

		// then
		XCTAssertEqual(sectionType, .completedTasks, "Полученный тип секции не соответствует ожидаемому")
	}
}

// MARK: - Private methods

private extension SectionAdapterTests {

	private func makeSut() -> SectionAdapter {
		taskManagerMock = TaskManagerMock()
		return SectionAdapter(taskManager: taskManagerMock)
	}
}

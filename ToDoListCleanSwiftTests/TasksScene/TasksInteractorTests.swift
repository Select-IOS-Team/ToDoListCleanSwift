//
//  TasksInteractorTests.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeni Meleshin on 23.03.2023.
//

import XCTest
import ToDoListBusinessLogic
@testable import ToDoListCleanSwift

/// Тестирует методы TasksInteractor
final class TasksInteractorTests: XCTestCase {

	private let worker = TasksWorkerSpy()
	private let presenter = TasksPresenterSpy()
	private var taskManagerSpy: TaskManagerSpy! // swiftlint:disable:this implicitly_unwrapped_optional

	func test_fetchSectionsWithTasksAndConvertToPresentModel_shouldBeCalled() {
		// arrange
		let sut = makeSut()

		// act
		sut.fetchSectionsWithTasksAndConvertToPresentModel()

		// assert
		XCTAssertTrue(worker.convertIsCalled, "Не был вызван worker.convertToTaskModelResponse")
		XCTAssertTrue(presenter.presentDataIsCalled, "Не был вызван presenter.presentData")
	}

	func test_didCheckboxTapped_withIndexPath_shouldBeCompleteTask() {
		// arrange
		let sut = makeSut()
		let task = makeStub()

		// act
		sut.didCheckboxTapped(indexPath: IndexPath(row: 0, section: 0))

		// assert
		XCTAssertTrue(task.isCompleted, "Задача должна быть выполнена")
	}
}

private extension TasksInteractorTests {
	func makeSut() -> TasksInteractor {
		taskManagerSpy = TaskManagerSpy()
		let sectionAdapter = SectionAdapter(taskManager: taskManagerSpy)
		let interactor = TasksInteractor()
		interactor.worker = worker
		interactor.presenter = presenter
		interactor.sectionsAdapter = sectionAdapter
		return interactor
	}
	func makeStub() -> Task {
		let task = RegularTask(title: "Regular task")
		taskManagerSpy.stubbedUncompletedTasksResult = [task]
		return task
	}
}

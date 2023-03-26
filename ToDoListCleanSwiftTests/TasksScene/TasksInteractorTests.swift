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

	private var worker: TasksWorkerSpy! // swiftlint:disable:this implicitly_unwrapped_optional
	private var presenter: TasksPresenterSpy! // swiftlint:disable:this implicitly_unwrapped_optional
	private var taskManagerSpy: TaskManagerSpy! // swiftlint:disable:this implicitly_unwrapped_optional
	private var sectionAdapterSpy: SectionAdapterSpy! // swiftlint:disable:this implicitly_unwrapped_optional

	func test_fetchSectionsWithTasksAndConvertToPresentModel_shouldBeCalled() {
		// arrange
		let sut = makeSut()
		taskManagerSpy = TaskManagerSpy()
		sectionAdapterSpy = SectionAdapterSpy(taskManager: taskManagerSpy)
		sut.sectionsAdapter = sectionAdapterSpy

		// act
		sut.fetchSectionsWithTasksAndConvertToPresentModel()

		// assert
		XCTAssertTrue(sectionAdapterSpy.getSectionsTypesIsCalled, "Не вызван метод sectionAdapter.getSectionType")
		XCTAssertTrue(
			sectionAdapterSpy.getTasksForSectionsTypeIsCalled,
			"Не вызван метод sectionAdapter.getTasksForSectionsType"
		)
		XCTAssertTrue(worker.convertIsCalled, "Не был вызван worker.convertToTaskModelResponse")
		XCTAssertTrue(presenter.presentDataIsCalled, "Не был вызван presenter.presentData")
	}

	func test_didCheckboxTapped_withIndexPath_shouldBeCompleteTask() {
		// arrange
		let sut = makeSut()
		let task = RegularTask(title: "Regular task")
		taskManagerSpy = TaskManagerSpy()
		taskManagerSpy.stubbedUncompletedTasksResult = [task]
		sectionAdapterSpy = SectionAdapterSpy(taskManager: taskManagerSpy)
		sut.sectionsAdapter = sectionAdapterSpy

		// act
		sut.didCheckboxTapped(indexPath: IndexPath(row: 0, section: 0))

		// assert
		XCTAssertTrue(sectionAdapterSpy.getSectionsTypesIsCalled, "Не вызван метод sectionAdapter.getSectionType")
		XCTAssertTrue(
			sectionAdapterSpy.getTasksForSectionsTypeIsCalled,
			"Не вызван метод sectionAdapter.getTasksForSectionsType"
		)
		XCTAssertTrue(task.isCompleted, "У задачи не произошла смена состояния выполненности")
	}
}

private extension TasksInteractorTests {
	func makeSut() -> TasksInteractor {
		worker = TasksWorkerSpy()
		presenter = TasksPresenterSpy()
		let interactor = TasksInteractor()
		interactor.worker = worker
		interactor.presenter = presenter
		return interactor
	}
}

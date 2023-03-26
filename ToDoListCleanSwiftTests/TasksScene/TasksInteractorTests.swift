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
		let request = prepareRequest()
		let expectedResponse = prepareExpectedResponse()
		worker.stubbedResponse = expectedResponse

		// act
		sut.fetchSectionsWithTasksAndConvertToPresentModel()

		// assert
		XCTAssertEqual(
			worker.stubbedRequest[0].sectionType,
			request[0].0,
			"Переданная в воркер секция 1 отличается от первой секции в реквесте"
		)
		XCTAssertEqual(
			worker.stubbedRequest[1].sectionType,
			request[1].0,
			"Переданная в воркер секция 2 отличается от второй секции в реквесте"
		)
		XCTAssertEqual(
			worker.stubbedRequest[0].tasks,
			request[1].1,
			"Переданный в воркер массив задач для секции 1 отличается от массива в реквесте"
		)
		XCTAssertEqual(
			presenter.invokedPresentParameters?.data,
			expectedResponse.data,
			"Передаваемое в презентер значение отличается от ожидаемого"
		)
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
		XCTAssertTrue(
			presenter.presentDataIsCalled,
			"Не вызван метод presenter.presentData"
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
	private func prepareRequest() -> [(SectionType, [Task])] {
		return [
			(section: SectionType.uncompletedTasks, tasks: [RegularTask(title: "Regular task")]),
			(section: SectionType.completedTasks, tasks: [])
		]
	}
	private func prepareExpectedResponse() -> TaskModel.Response {
		let dataUncompletedTasks = TaskModel.ResponseData(
			sectionType: .uncompletedTasks, sectionTasks: [RegularTask(title: "Regular task")]
		)
		let dataCompletedTasks = TaskModel.ResponseData(
			sectionType: .completedTasks, sectionTasks: []
		)
		return TaskModel.Response(data: [dataUncompletedTasks, dataCompletedTasks])
	}
}

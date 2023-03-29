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

	// MARK: - Private properties

	private var workerSpy: TasksWorkerSpy! // swiftlint:disable:this implicitly_unwrapped_optional
	private var presenterSpy: TasksPresenterSpy! // swiftlint:disable:this implicitly_unwrapped_optional
	private var sectionAdapterSpy: SectionAdapterSpy! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: - Tests

	func test_fetchSectionsWithTasksAndConvertToPresentModel_shouldBeCalled() {
		// arrange
		let sut = makeSut()
		taskManagerSpy = TaskManagerSpy()
		sectionAdapterSpy = SectionAdapterSpy(taskManager: taskManagerSpy)
		sut.sectionsAdapter = sectionAdapterSpy

		let sectionTypes = [SectionType.uncompletedTasks, SectionType.completedTasks]
		sectionAdapterSpy.stubbedGetSectionsTypesResult = sectionTypes
		sectionAdapterSpy.stubbedGetTasksForSectionsTypeResult = [
			RegularTask(title: "Task 1"),
			RegularTask(title: "Task 2")
		]
		let expectedData: [(sectionType: SectionType, tasks: [Task])] = [
			(sectionType: .uncompletedTasks, tasks: [RegularTask(title: "Task 1"), RegularTask(title: "Task 2")]),
			(sectionType: .completedTasks, tasks: [RegularTask(title: "Task 1"), RegularTask(title: "Task 2")])
		]
		let expectedResponse = prepareExpectedResponse()
		workerSpy.stubbedConvertToTaskModelResponseResult = expectedResponse

		// act
		sut.fetchData()

		// assert
		XCTAssertTrue(sectionAdapterSpy.invokedGetSectionsTypes, "Не вызван метод sectionAdapter.getSectionsTypes()")
		XCTAssertEqual(
			sectionTypes.count,
			sectionAdapterSpy.invokedGetTasksForSectionsTypeCount,
			"Количество секций полученное в методе sectionAdapter.getSectionsTypes() не соответствует ожидаемым"
		)

		XCTAssertTrue(sectionAdapterSpy.invokedGetTasksForSectionsType, "Не вызван sectionAdapter.getTasksForSectionsType()")
		XCTAssertEqual(
			sectionAdapterSpy.invokedGetTasksForSectionsTypeParametersList.map { $0.sectionType },
			sectionTypes,
			"Типы секций полученные в методе sectionAdapter.getTasksForSectionsType() не соответствуют ожидаемым"
		)

		XCTAssertTrue(workerSpy.invokedConvertToTaskModelResponse, "Не был вызван метод worker.convertToTaskModelResponse()")
		XCTAssertEqual(
			workerSpy.invokedConvertToTaskModelResponseParameters?.data.map { $0.sectionType },
			expectedData.map { $0.sectionType },
			"Типы секций полученные в методе worker.convertToTaskModelResponse() не соответствуют ожидаемым"
		)
		XCTAssertEqual(
			workerSpy.invokedConvertToTaskModelResponseParameters?.data.map { $0.tasks },
			expectedData.map { $0.tasks },
			"Задачи секции 1 полученные в методе worker.convertToTaskModelResponse() не соответствуют ожидаемым"
		)

		XCTAssertTrue(presenterSpy.invokedPresentData, "Не вызван presenter.presentData()")
		XCTAssertEqual(
			presenterSpy.invokedPresentDataParameters?.response,
			expectedResponse,
			"Структура секций с задачами в методе presenter.presentData() не соответствует ожидаемой"
		)
	}

	func test_didCheckboxTapped_withIndexPath_shouldBeCompleteTask() {
		// arrange
		let sut = makeSut()

		let sectionType = SectionType.uncompletedTasks
		sectionAdapterSpy.stubbedGetSectionTypeResult = sectionType
		let task = RegularTask(title: "Task")
		sectionAdapterSpy.stubbedGetTasksForSectionsTypeResult = [task]
		workerSpy.stubbedConvertToTaskModelResponseResult = prepareExpectedResponse()
		let indexPath = IndexPath(row: 0, section: 0)

		// act
		sut.didCheckboxTapped(indexPath: indexPath)

		// assert
		XCTAssertTrue(sectionAdapterSpy.invokedGetSectionType, "Не вызван метод sectionAdapter.getSectionType")
		XCTAssertEqual(
			sectionAdapterSpy.invokedGetSectionTypeParameters?.index,
			indexPath.section,
			"Переданный в метод sectionAdapter.getSectionType индекс секции должен быть indexPath.section [0]"
		)
		XCTAssertTrue(
			sectionAdapterSpy.invokedGetTasksForSectionsType,
			"Не вызван метод sectionAdapter.getTasksForSectionsType"
		)
		XCTAssertEqual(
			sectionAdapterSpy.invokedGetTasksForSectionsTypeParameters?.sectionType,
			sectionType,
			"Переданная в метод sectionAdapter.getTasksForSectionsType секция не соответствует ожидаемой"
		)

		XCTAssertEqual(
			sectionAdapterSpy.stubbedGetTasksForSectionsTypeResult[indexPath.row],
			task,
			"Первая задача первой секции не соответствует ожидаемой"
		)

		XCTAssertTrue(task.isCompleted, "После выполнения метода didCheckboxTapped задача должна быть выполненной")
	}
}

// MARK: - Private

private extension TasksInteractorTests {
	func makeSut() -> TasksInteractor {
		workerSpy = TasksWorkerSpy()
		presenterSpy = TasksPresenterSpy()
		sectionAdapterSpy = SectionAdapterSpy()
		let interactor = TasksInteractor()
		interactor.worker = workerSpy
		interactor.presenter = presenterSpy
		interactor.sectionsAdapter = sectionAdapterSpy
		return interactor
	}
}

// MARK: - TestData
private extension TasksInteractorTests {
	func prepareExpectedResponse() -> TaskModel.Response {
		let expectedResponse = TaskModel.Response(
			data: [
				TaskModel.ResponseData(
					sectionType: .completedTasks,
					sectionTasks: [RegularTask(title: "Task 1"), RegularTask(title: "Task 2")]
				),
				TaskModel.ResponseData(
					sectionType: .uncompletedTasks,
					sectionTasks: [RegularTask(title: "Task 1")]
				)
			]
		)
		return expectedResponse
	}
}

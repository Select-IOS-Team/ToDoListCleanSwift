//
//  TasksPresenterTests.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeni Meleshin on 24.03.2023.
//

import XCTest
import ToDoListBusinessLogic
@testable import ToDoListCleanSwift

// swiftlint:disable function_body_length

final class TasksPresenterTests: XCTestCase {

	// MARK: - Private properties

	private var viewControllerSpy: TasksViewControllerSpy! // swiftlint:disable:this implicitly_unwrapped_optional
	private var taskManagerSpy: TaskManagerSpy! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: - Tests

	func test_presentData_withValidResponse_shouldBeRenderSuccess() {
		// arrange
		let sut = makeSut()

		let importantTask = ImportantTask(title: "Important task 1", priority: .high)
		let responseUncompletedTasks = TaskModel.ResponseData(
			sectionType: .uncompletedTasks,
			sectionTasks: [
				RegularTask(title: "Regular task 1"),
				RegularTask(title: "Regular task 2")
			]
		)
		let responseCompletedTasks = TaskModel.ResponseData(
			sectionType: .completedTasks,
			sectionTasks: [
				RegularTask(title: "Regular task 3"),
				importantTask
			]
		)
		let response = TaskModel.Response(data: [responseUncompletedTasks, responseCompletedTasks])

		let regularTask1 = TaskModel.ViewData.RegularTask(title: "Regular task 1", checkboxImageName: "circle")
		let regularTask2 = TaskModel.ViewData.RegularTask(title: "Regular task 2", checkboxImageName: "circle")
		let regularTask3 = TaskModel.ViewData.RegularTask(title: "Regular task 3", checkboxImageName: "circle")
		let importantTaskViewData = TaskModel.ViewData.ImportantTask(
			title: "Important task 1",
			checkboxImageName: "circle",
			isExpired: false,
			priorityText: "Priority: high",
			executionDate: getStringByDate(importantTask.completionDate)
		)
		let uncompletedTasks = [
			TaskModel.ViewData.Task.regularTask(regularTask1),
			TaskModel.ViewData.Task.regularTask(regularTask2)
		]
		let completedTasks = [
			TaskModel.ViewData.Task.regularTask(regularTask3),
			TaskModel.ViewData.Task.importantTask(importantTaskViewData)
		]
		let sectionUncompletedTasks = TaskModel.ViewData.Section(
			title: "Uncompleted tasks",
			tasks: uncompletedTasks
		)
		let sectionCompletedTasks = TaskModel.ViewData.Section(
			title: "Completed tasks",
			tasks: completedTasks
		)
		let expectedViewData = TaskModel.ViewData(tasksBySections: [sectionUncompletedTasks, sectionCompletedTasks])

		// act
		sut.presentData(response: response)

		// assert
		XCTAssertTrue(viewControllerSpy.invokedRender, "Не был вызван viewController.render")
		XCTAssertEqual(
			viewControllerSpy.invokedRenderParameters?.viewData,
			expectedViewData,
			"Переданная в метод viewController.render структура вью модели отличается от ожидаемой"
		)
	}
}

// MARK: - Private

private extension TasksPresenterTests {
	func makeSut() -> TasksPresenter {
		let presenter = TasksPresenter()
		viewControllerSpy = TasksViewControllerSpy()
		presenter.viewController = viewControllerSpy
		return presenter
	}
}

// MARK: - TestData

private extension TasksPresenterTests {
	private func getStringByDate(_ date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd.MM.yyyy HH:mm"
		return formatter.string(from: date)
	}
}
// swiftlint:enable function_body_length

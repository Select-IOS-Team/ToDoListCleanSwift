//
//  TasksPresenterTests.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeni Meleshin on 24.03.2023.
//

import XCTest
import ToDoListBusinessLogic
@testable import ToDoListCleanSwift

final class TasksPresenterTests: XCTestCase {

	private var viewControllerSpy: TasksViewControllerSpy! // swiftlint:disable:this implicitly_unwrapped_optional
	private var taskManagerSpy: TaskManagerSpy! // swiftlint:disable:this implicitly_unwrapped_optional

	func test_presentData_withValidResponce_shouldBeRenderSuccess() {
		// arrange
		let sut = makeSut()

		let response = TaskModel.Response(
			data: [
				TaskModel.ResponseData(
					sectionType: .uncompletedTasks,
					sectionTasks: [RegularTask(title: "Regular task 1")]
				)
			]
		)

		let regularTask = TaskModel.ViewData.RegularTask(title: "Regular task 1", checkboxImageName: "circle")
		let uncompletedTasks = [TaskModel.ViewData.Task.regularTask(regularTask)]
		let sectionUncompletedTasks = TaskModel.ViewData.Section(
			title: SectionType.uncompletedTasks.description,
			tasks: uncompletedTasks
		)
		let expectedViewData = TaskModel.ViewData(tasksBySections: [sectionUncompletedTasks])
		viewControllerSpy.invokedRenderParameters = (viewData: expectedViewData, ())

		// act
		sut.presentData(response: response)

		// assert
		XCTAssertTrue(viewControllerSpy.invokedRender, "Не был вызван viewController.render")
		XCTAssertEqual(
			viewControllerSpy.invokedRenderParametersList.map { $0.viewData }.first,
			expectedViewData,
			"Переданная в метод viewController.render структура вью модели отличается от ожидаемой"
		)
	}
}

private extension TasksPresenterTests {
	func makeSut() -> TasksPresenter {
		let sectionAdapterSpy = SectionAdapterSpy()
		let presenter = TasksPresenter(sectionsAdapter: sectionAdapterSpy)
		viewControllerSpy = TasksViewControllerSpy()
		presenter.view = viewControllerSpy
		return presenter
	}
}

//
//  TasksViewControllerTests.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeni Meleshin on 24.03.2023.
//

import XCTest
import ToDoListBusinessLogic
@testable import ToDoListCleanSwift

final class TasksViewControllerTests: XCTestCase {

	// MARK: - Private properties

	private var interactor: TasksInteractorSpy! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: - Tests

	func test_viewDidLoad_shouldBeLoadSuccess() {
		// arrange
		interactor = TasksInteractorSpy()
		let sut = TasksViewController(interactor: interactor)

		// act
		sut.viewDidLoad()

		// assert
		XCTAssertTrue(interactor.invokedFetchData, "Не был вызван interactor.fetchData")
	}

	func test_render_shouldBeReceiveValidData() {
		// arrange
		interactor = TasksInteractorSpy()
		let sut = TasksViewController(interactor: interactor)
		let viewData = expectedViewData()

		// act
		sut.render(viewData: viewData)

		// assert
		XCTAssertEqual(
			sut.viewData,
			viewData,
			"Переданная в метод taskViewController.render вью модель отличается от ожидаемой"
		)
	}
}

// MARK: - TestData

private extension TasksViewControllerTests {
	func expectedViewData() -> TaskModel.ViewData {
		let regularTask = TaskModel.ViewData.RegularTask(title: "Regular task", checkboxImageName: "")
		let tasks = TaskModel.ViewData.Task.regularTask(regularTask)
		let section = TaskModel.ViewData.Section(title: "Невыполненные задачи", tasks: [tasks])
		return TaskModel.ViewData(tasksBySections: [section])
	}
}

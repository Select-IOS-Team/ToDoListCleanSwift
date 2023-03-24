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

	private let viewController = TasksViewControllerSpy()
	private var taskManagerSpy: TaskManagerSpy! // swiftlint:disable:this implicitly_unwrapped_optional

	func test_presentData_withValidResponce_shouldBeRenderSuccess() {
		// arrange
		let sut = makeSut()
		let response = TaskModel.Response(data: [])

		// act
		sut.presentData(response: response)

		// assert
		XCTAssertTrue(viewController.renderIsCalled, "Не был вызван viewController.render")
	}
}

private extension TasksPresenterTests {
	func makeSut() -> TasksPresenter {
		taskManagerSpy = TaskManagerSpy()
		let sectionAdapter = SectionAdapter(taskManager: taskManagerSpy)
		let presenter = TasksPresenter(sectionsAdapter: sectionAdapter)
		presenter.view = viewController
		return presenter
	}
}

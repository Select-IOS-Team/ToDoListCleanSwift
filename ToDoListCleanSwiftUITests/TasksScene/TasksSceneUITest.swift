//
//  TasksSceneUITest.swift
//  ToDoListCleanSwiftUITests
//
//  Created by Evgeni Meleshin on 14.04.2023.
//

import XCTest

// swiftlint: disable all
final class TasksSceneUITest: XCTestCase {

	func test_uncompletedTasksSection_forRegularTask_MustHaveCorrectTitle() {
		let app = XCUIApplication()
		let loginScreen = LoginScreenObject(app: app)

		app.launch()

		loginScreen
			.isLoginScreen()
			.set(login: "1")
			.set(password: "1")
			.successfulLogin()
			.isTasksScreen()
			.isCellRegularTask()
			.uncompletedTasksSectionTitleIsCorrect(title: "Uncompleted tasks")
	}

	func test_completedTasksSection_forRegularTask_MustHaveCorrectTitle() {
		let app = XCUIApplication()
		let loginScreen = LoginScreenObject(app: app)

		app.launch()

		loginScreen
			.isLoginScreen()
			.set(login: "1")
			.set(password: "1")
			.successfulLogin()
			.isTasksScreen()
			.isCellRegularTask()
			.completedTasksSectionTitleIsCorrect(title: "Completed tasks")
	}

	func test_regularTask_MustBeComplete() {
		let app = XCUIApplication()
		let loginScreen = LoginScreenObject(app: app)

		app.launch()

		loginScreen
			.isLoginScreen()
			.set(login: "1")
			.set(password: "1")
			.successfulLogin()
			.isTasksScreen()
			.isCellRegularTask()
			.checkBoxRegularTaskTap()
	}
}
// swiftlint: enable all

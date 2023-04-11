//
//  TasksScreenObject.swift
//  ToDoListCleanSwiftUITests
//
//  Created by Evgeni Meleshin on 11.04.2023.
//

import XCTest

class TasksScreenObject: BaseScreenObject {

	// MARK: - Private properties

	private lazy var tasksTableView = app.tables[AccessibilityIdentifier.tasksTableView.rawValue]

	// MARK: - ScreenObject Methods

	@discardableResult
	func isTasksScreen() -> Self {
		assert(tasksTableView, [.exists])
		return self
	}
}

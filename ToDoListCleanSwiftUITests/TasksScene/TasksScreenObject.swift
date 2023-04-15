//
//  TasksScreenObject.swift
//  ToDoListCleanSwiftUITests
//
//  Created by Evgeni Meleshin on 11.04.2023.
//

// swiftlint: disable all
import XCTest

class TasksScreenObject: BaseScreenObject {

	// MARK: - Private properties

	private lazy var tasksTableView = app.tables[AccessibilityIdentifier.tasksTableView.rawValue]

	// Sections
	private lazy var uncompletedTasksSection = app.tables.otherElements["\(AccessibilityIdentifier.section.rawValue)-0"]
	private lazy var completedTasksSection = app.tables.otherElements["\(AccessibilityIdentifier.section.rawValue)-1"]

	// Section labels
	private lazy var labelUncompletedTasksSection = uncompletedTasksSection.staticTexts["\(AccessibilityIdentifier.sectionLabel.rawValue)-0"]
	private lazy var labelCompletedTasksSection = completedTasksSection.staticTexts["\(AccessibilityIdentifier.sectionLabel.rawValue)-1"]

	// Regular task elements
	private lazy var cellRegularTask = app.tables.cells["\(AccessibilityIdentifier.cell.rawValue)-0-8"]
	private lazy var checkBoxRegularTask = cellRegularTask.images[AccessibilityIdentifier.checkBoxRegularTask.rawValue]
	private lazy var titleLabelRegularTask = cellRegularTask.staticTexts[AccessibilityIdentifier.titleLabelRegularTask.rawValue]

	// Important task elements
	private lazy var cellImportantTask = app.tables.cells["\(AccessibilityIdentifier.cell.rawValue)-0-0"]
	private lazy var checkBoxImportantTask = cellImportantTask.images[AccessibilityIdentifier.checkBoxImportantTask.rawValue]
	private lazy var titleLabelImportantTask = cellImportantTask.staticTexts[AccessibilityIdentifier.titleLabelImportantTask.rawValue]
	private lazy var priorityLabel = cellImportantTask.staticTexts[AccessibilityIdentifier.priorityLabel.rawValue]
	private lazy var executionDateLabel = cellImportantTask.staticTexts[AccessibilityIdentifier.executionDateLabel.rawValue]

	// MARK: - ScreenObject Methods

	@discardableResult
	func isTasksScreen() -> Self {
		assert(tasksTableView, [.exists])
		return self
	}

	@discardableResult
	func isCellRegularTask() -> Self {
		assert(cellRegularTask, [.exists])
		return self
	}

	@discardableResult
	func uncompletedTasksSectionTitleIsCorrect(title: String) -> Self {
		assert(labelUncompletedTasksSection, [.contains(title)])
		return self
	}

	@discardableResult
	func checkBoxRegularTaskTap() -> Self {
		assert(checkBoxRegularTask, [.exists, .isEnabled, .isHittable])
		checkBoxRegularTask.tap()
		return self
	}

	@discardableResult
	func completedTasksSectionTitleIsCorrect(title: String) -> Self {
		assert(labelCompletedTasksSection, [.contains(title)])
		return self
	}

	@discardableResult
	func checkBoxImportantTaskTap() -> Self {
		assert(checkBoxImportantTask, [.exists, .isEnabled, .isHittable])
		checkBoxImportantTask.tap()
		return self
	}
}
// swiftlint: enable all

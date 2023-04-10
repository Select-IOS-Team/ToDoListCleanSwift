//
//  AccessibilityIdentifier.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 04.04.2023.
//

/// Accessibility identifiers для UI компонентов
enum AccessibilityIdentifier: String {

	// MARK: - LoginScene
	case loginTextField
	case passwordTextField
	case loginButton

	// MARK: - TasksScene
	case tasksTableView
	case checkBoxRegularTask
	case titleLabelRegularTask
	case checkBoxImportantTask
	case titleLabelImportantTask
	case priorityLabel
	case executionDateLabel
}

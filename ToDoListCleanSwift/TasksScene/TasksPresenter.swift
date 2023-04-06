//
//  TasksPresenter.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//

import Foundation
import ToDoListBusinessLogic

/// Презентер, подготавливающий модель вью для вьюконтроллера
protocol ITasksPresenter {
	/// Преобразует данные из`TaskModel.Response` в модели секций `TaskModel.ViewData.Section` и распределяет по ним задачи
	/// - Parameter response: структура `TaskModel.Response`
	func presentData(response: TaskModel.Response)
}

/// Класс презентера
class TasksPresenter: ITasksPresenter {

	// MARK: - Nested types

	private enum Constants {
		static let completedCheckboxImageName = L10n.TasksScene.completedCheckboxImageName
		static let uncompletedCheckboxImageName = L10n.TasksScene.uncompletedCheckboxImageName
		static let priorityLabelText = L10n.TasksScene.priorityLabelText
	}

	weak var view: ITasksViewController?
	private var sectionsAdapter: ISectionsAdapter

	init(sectionsAdapter: ISectionsAdapter) {
		self.sectionsAdapter = sectionsAdapter
	}

	func presentData(response: TaskModel.Response) {
		var sectionTypes = [TaskModel.ViewData.Section]()
		for dataItem in response.data {
			let section = TaskModel.ViewData.Section(
				title: dataItem.sectionType.description,
				tasks: createViewDataFromTasks(tasks: dataItem.sectionTasks)
			)
			sectionTypes.append(section)
		}
		view?.render(viewData: TaskModel.ViewData(tasksBySections: sectionTypes))
	}

	private func createViewDataFromTasks(tasks: [Task]) -> [TaskModel.ViewData.Task] {
		tasks.map { createViewData(task: $0) }
	}

	private func createViewData(task: Task) -> TaskModel.ViewData.Task {
		if let importantTask = task as? ImportantTask {
			let importantTask = TaskModel.ViewData.ImportantTask(
				title: importantTask.title,
				checkboxImageName: checkboxImageName(for: importantTask),
				isExpired: importantTask.completionDate < Date(),
				priorityText: Constants.priorityLabelText + importantTask.priority.description,
				executionDate: getStringByDate(importantTask.completionDate)
			)
			return .importantTask(importantTask)
		} else {
			return .regularTask(
				TaskModel.ViewData.RegularTask(
					title: task.title,
					checkboxImageName: checkboxImageName(for: task)
				)
			)
		}
	}

	private func getStringByDate(_ date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = L10n.TasksScene.dateFormat
		return formatter.string(from: date)
	}

	private func checkboxImageName(for task: Task) -> String {
		task.isCompleted ? Constants.completedCheckboxImageName : Constants.uncompletedCheckboxImageName
	}
}

private extension ImportantTask.Priority {
	/// Описание приоритета важной задачи
	var description: String {
		switch self {
		case .high:
			return L10n.TasksScene.priorityHigh
		case .medium:
			return L10n.TasksScene.priorityMedium
		case .low:
			return L10n.TasksScene.priorityLow
		}
	}
}

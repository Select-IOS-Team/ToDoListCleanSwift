//
//  TasksPresenter.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//

import Foundation
import ToDoListBusinessLogic

/// Протокол презентера
protocol ITasksPresenter {
	func presentData(response: TaskModel.Response)
}

/// Класс презентера
class TasksPresenter: ITasksPresenter {

	// MARK: - Nested types

	private enum Constants {
		static let completedCheckboxImageName = "checkmark.circle.fill"
		static let uncompletedCheckboxImageName = "circle"
		static let priorityLabelText = "Priority: "
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
		formatter.dateFormat = "dd.MM.yyyy HH:mm"
		return formatter.string(from: date)
	}

	private func checkboxImageName(for task: Task) -> String {
		task.isCompleted ? Constants.completedCheckboxImageName : Constants.uncompletedCheckboxImageName
	}
}

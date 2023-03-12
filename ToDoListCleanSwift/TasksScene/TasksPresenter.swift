//
//  TasksPresenter.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//

import Foundation

/// Протокол презентера
protocol ITasksPresenter {
	func presentData(response: TaskModel.Response)
}

/// Класс презентера
class TasksPresenter: ITasksPresenter {

	private weak var view: ITasksViewController!
	private var sectionsAdapter: ISectionsAdapter!

	init(view: ITasksViewController!, sectionsAdapter: ISectionsAdapter!) {
		self.view = view
		self.sectionsAdapter = sectionsAdapter
	}

	func presentData(response: TaskModel.Response) {
		var sectionTypes = [TaskModel.ViewData.Section]()
		for dataItem in response.data {
			let section = TaskModel.ViewData.Section(
				title: dataItem.sectionType.description,
				tasks: createViewDataFromTasks(tasks: dataItem.sectionTasks))
			sectionTypes.append(section)
		}
		view.render(viewData: TaskModel.ViewData(tasksBySections: sectionTypes))
	}

	private func createViewDataFromTasks(tasks: [Task]) -> [TaskModel.ViewData.Task] {
		tasks.map { createViewData(task: $0) }
	}

	private func createViewData(task: Task) -> TaskModel.ViewData.Task {
		if let task = task as? ImportantTask {
			let importantTask = TaskModel.ViewData.ImportantTask(
				title: task.title,
				completed: task.completed,
				priority: task.priority.description,
				completionDate: getStringByDate(date: task.completionDate),
				overdue: task.completionDate < Date() ? true : false)
			return .importantTask(importantTask)
		} else {
			return .regularTask(TaskModel.ViewData.RegularLask(
				title: task.title,
				completed: task.completed
			))
		}
	}

	private func getStringByDate(date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd.MM.yyyy HH:mm"
		return formatter.string(from: date)
	}
}

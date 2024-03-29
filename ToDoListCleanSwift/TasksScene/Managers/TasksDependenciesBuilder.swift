//
//  TasksDependenciesBuilder.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 22.02.2023.
//

import Foundation
import ToDoListBusinessLogic

/// Класс сборщика
enum TasksDependenciesBuilder {
	static func build() -> TasksViewController {

		let tasksWorker: ITasksWorker = TasksWorker()
		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: IRepository = Repository()
		taskManager.addTasks(tasks: repository.getAllTasks())

		let sectionsAdapter = SectionAdapter(taskManager: taskManager)
		let tasksPresenter = TasksPresenter()
		let tasksInteractor = TasksInteractor(
			sectionsAdapter: sectionsAdapter,
			presenter: tasksPresenter,
			worker: tasksWorker
		)
		let tasksViewController = TasksViewController(interactor: tasksInteractor)
		tasksPresenter.viewController = tasksViewController

		return tasksViewController
	}
}

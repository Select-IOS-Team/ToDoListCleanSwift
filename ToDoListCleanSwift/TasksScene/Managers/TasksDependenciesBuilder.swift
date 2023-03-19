//
//  TasksDependenciesBuilder.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 22.02.2023.
//

import Foundation

/// Класс сборщика
enum TasksDependenciesBuilder {
	static func build() -> TasksViewController {

		let tasksViewController = TasksViewController()
		let tasksWorker: ITasksWorker = TasksWorker()
		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: IRepository = Repository()
		let sectionsAdapter = SectionAdapter(taskManager: taskManager)
		let tasksPresenter = TasksPresenter(sectionsAdapter: sectionsAdapter)
		let tasksInteractor = TasksInteractor()

		tasksPresenter.view = tasksViewController
		tasksViewController.interactor = tasksInteractor
		tasksInteractor.presenter = tasksPresenter
		tasksInteractor.worker = tasksWorker
		tasksInteractor.sectionsAdapter = sectionsAdapter

		taskManager.addTasks(tasks: repository.getAllTasks())
		return tasksViewController
	}
}

//
//  TasksDependenciesBuilder.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 22.02.2023.
//

import Foundation

/// Класс сборщика
final class TasksDependenciesBuilder {
	static func build() -> TasksViewController {
		
		let tasksViewController = TasksViewController()
		let tasksWorker: ITasksWorker = TasksWorker()
		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: IRepository = Repository()
		let sectionsAdapter = SectionAdapter(taskManager: taskManager)
		let tasksPresenter: ITasksPresenter = TasksPresenter(view: tasksViewController, sectionsAdapter: sectionsAdapter)
		let tasksInteractor = TasksInteractor()
		
		tasksViewController.interactor = tasksInteractor
		tasksInteractor.presenter = tasksPresenter
		tasksInteractor.worker = tasksWorker
		tasksInteractor.sectionsAdapter = sectionsAdapter
		
		taskManager.addTasks(tasks: repository.getAllTasks())
		return tasksViewController
	}
}

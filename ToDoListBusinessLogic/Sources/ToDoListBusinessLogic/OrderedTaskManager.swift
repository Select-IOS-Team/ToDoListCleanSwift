//
//  OrderedTaskManager.swift
//  ToDoListBusinessLogic
//
//  Created by Evgeni Meleshin on 16.02.2023.
//

import Foundation

/// Менеджер задач, предоставляющий задачи в отсортированном по приоритету порядке.
public final class OrderedTaskManager: ITaskManager {

	// MARK: - Private properties

	private let taskManager: ITaskManager

	// MARK: - Lifecycle

	public init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	// MARK: - ITaskManager

	public func allTasks() -> [Task] {
		sorted(tasks: taskManager.allTasks())
	}

	public func completedTasks() -> [Task] {
		sorted(tasks: taskManager.completedTasks())
	}

	public func uncompletedTasks() -> [Task] {
		sorted(tasks: taskManager.uncompletedTasks())
	}

	public func addTask(task: Task) {
		taskManager.addTask(task: task)
	}

	public func addTasks(tasks: [Task]) {
		taskManager.addTasks(tasks: tasks)
	}

	public func removeTask(task: Task) {
		taskManager.removeTask(task: task)
	}

	// MARK: - Private methods

	private func sorted(tasks: [Task]) -> [Task] {
		tasks.sorted {
			if let task0 = $0 as? ImportantTask, let task1 = $1 as? ImportantTask {
				return task0.priority < task1.priority
			}

			if $0 is ImportantTask, $1 is RegularTask {
				return true
			}

			if $0 is RegularTask, $1 is ImportantTask {
				return false
			}

			return true
		}
	}
}

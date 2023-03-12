//
//  OrderedTaskManager.swift
//  TodoList
//
//  Created by Evgeni Meleshin on 16.02.2023.
//

import Foundation

/// Класс сортирующего задачи менеджера
final class OrderedTaskManager: ITaskManager {
	
	let taskManager: ITaskManager
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	/// Получить и отсортировать все задачи
	public func allTasks() -> [Task] {
		sorted(tasks: taskManager.allTasks())
	}
	
	/// Получить и отсортировать выполненные задачи
	public func completedTasks() -> [Task] {
		sorted(tasks: taskManager.completedTasks())
	}
	
	/// Получить и отсортировать невыполненные задачи
	public func uncompletedTasks() -> [Task] {
		sorted(tasks: taskManager.uncompletedTasks())
	}
	
	/// Добавить задачи
	public func addTasks(tasks: [Task]) {
		taskManager.addTasks(tasks: tasks)
	}
	
	private func sorted(tasks: [Task]) -> [Task] {
		tasks.sorted {
			if let task0 = $0 as? ImportantTask, let task1 = $1 as? ImportantTask {
				return task0.priority.dayCountForCompletion < task1.priority.dayCountForCompletion
			}
			
			if $0 is ImportantTask, $1 is RegularTask {
				return true
			}
		
			if  $0 is RegularTask, $1 is ImportantTask {
				return false
			}

			return true
		}
	}
	
}

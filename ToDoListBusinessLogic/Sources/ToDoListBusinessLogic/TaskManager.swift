//
//  TaskManager.swift
//  TodoList
//
//  Created by Evgeni Meleshin on 10.02.2023.
//

import Foundation

/// Протокол менеджера задач
public protocol ITaskManager {
	/// Получает все задачи
	func allTasks() -> [Task]
	/// Получает выполненные задачи
	func completedTasks() -> [Task]
	/// Получает невыполненные задачи
	func uncompletedTasks() -> [Task]
	/// Добавляет задачи
	func addTasks(tasks: [Task])
}

/// Класс менеджера задач
public final class TaskManager {
	/// Список задач
	private var tasksList: [Task] = []
	/// Инициализатор
	public init() {}
	/// Получить все задачи
	public func allTasks() -> [Task] {
		tasksList
	}
	/// Получить выполненные задачи
	public func completedTasks() -> [Task] {
		tasksList.filter { $0.isCompleted == true }
	}
	/// Получить навыполненные задачи
	public func uncompletedTasks() -> [Task] {
		return tasksList.filter { $0.isCompleted != true }
	}
	/// Добавить задачу в список
	public func addTask(task: Task) {
		tasksList.append(task)
	}
	/// Добавить задачи
	/// - Parameter tasks: массив новых задач
	public func addTasks(tasks: [Task]) {
		tasksList.append(contentsOf: tasks)
	}
	/// Удалить задачу из списка
	public func removeTask(task: Task) {
		tasksList.removeAll { value in value === task }
	}
}

extension TaskManager: ITaskManager {}

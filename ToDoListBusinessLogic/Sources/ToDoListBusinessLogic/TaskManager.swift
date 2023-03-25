//
//  TaskManager.swift
//  ToDoListBusinessLogic
//
//  Created by Evgeni Meleshin on 10.02.2023.
//

import Foundation

/// Менеджер задач.
public protocol ITaskManager {
	/// Возвращает все задачи.
	func allTasks() -> [Task]
	/// Возвращает выполненные задачи.
	func completedTasks() -> [Task]
	/// Возвращает невыполненные задачи.
	func uncompletedTasks() -> [Task]
	/// Добавляет задачу.
	/// - Parameter task: Добавляемая задача.
	func addTask(task: Task)
	/// Добавляет массив задач.
	/// - Parameter tasks: Массив добавляемых задач.
	func addTasks(tasks: [Task])
	/// Удаляет задачу.
	/// - Parameter task: Задача, которую необходимо удалить.
	func removeTask(task: Task)
}

/// Класс менеджера задач
public final class TaskManager: ITaskManager {

	// MARK: - Private properties

	private var tasksList: [Task] = []

	// MARK: - Lifecycle

	/// Инициализатор
	public init() {}

	// MARK: - ITaskManager

	public func allTasks() -> [Task] {
		tasksList
	}

	public func completedTasks() -> [Task] {
		tasksList.filter { $0.isCompleted }
	}

	public func uncompletedTasks() -> [Task] {
		return tasksList.filter { !$0.isCompleted }
	}

	public func addTask(task: Task) {
		tasksList.append(task)
	}

	public func addTasks(tasks: [Task]) {
		tasksList.append(contentsOf: tasks)
	}

	public func removeTask(task: Task) {
		tasksList.removeAll { $0 === task }
	}
}

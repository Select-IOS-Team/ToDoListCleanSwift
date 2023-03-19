//
//  TaskManager.swift
//  TodoList
//
//  Created by Evgeni Meleshin on 10.02.2023.
//

import Foundation

/// Приоритет важных задач.
enum ImportantTaskPriority: CustomStringConvertible, CaseIterable {
	case high
	case medium
	case low

	/// Количество дней на выполнение задачи на основе её приоритета.
	var dayCountForCompletion: Int {
		// swiftlint:disable numbers_smell
		switch self {
		case .high:
			return 1
		case .medium:
			return 2
		case .low:
			return 3
		}
		// swiftlint:enable numbers_smell
	}

	/// Описание приоритета
	var description: String {
		switch self {
		case .high:
			return "high"
		case .medium:
			return "medium"
		case .low:
			return "low"
		}
	}
}

/// Протокол менеджера задач
protocol ITaskManager {
	func allTasks() -> [Task]
	func completedTasks() -> [Task]
	func uncompletedTasks() -> [Task]
	func addTasks(tasks: [Task])
}

/// Класс менеджера задач
final class TaskManager {

	/// Список задач
	private var tasksList: [Task] = []

	/// Получить все задачи
	func allTasks() -> [Task] {
		tasksList
	}

	/// Получить выполненные задачи
	func completedTasks() -> [Task] {
		tasksList.filter { $0.isCompleted == true }
	}

	/// Получить навыполненные задачи
	func uncompletedTasks() -> [Task] {
		return tasksList.filter { $0.isCompleted != true }
	}

	/// Добавить задачу в список
	func addTask(task: Task) {
		tasksList.append(task)
	}

	/// Добавить задачи
	/// - Parameter tasks: массив новых задач
	func addTasks(tasks: [Task]) {
		tasksList.append(contentsOf: tasks)
	}

	/// Удалить задачу из списка
	func removeTask(task: Task) {
		tasksList.removeAll { value in value === task }
	}
}

extension TaskManager: ITaskManager {}

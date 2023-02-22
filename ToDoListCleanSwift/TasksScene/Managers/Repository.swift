//
//  TaskRepository.swift
//  TodoList
//
//  Created by Evgeni Meleshin on 14.02.2023.
//

import Foundation

/// Протокол репозитория
protocol IRepository {
	func getAllTasks() -> [Task]
}

/// Класс репозитория
final class Repository: IRepository {
	
	/// Получить все задачи
	func getAllTasks() -> [Task] {
		[
			RegularTask(title: "Regular task 1"),
			RegularTask(title: "Regular task 2"),
			ImportantTask(title: "Important task 1", priority: .high),
			ImportantTask(title: "Important task 2", priority: .medium),
			ImportantTask(title: "Important task 3", priority: .low)
		]
	}
	
}

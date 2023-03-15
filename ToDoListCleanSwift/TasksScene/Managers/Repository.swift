//
//  TaskRepository.swift
//  TodoList
//
//  Created by Evgeni Meleshin on 14.02.2023.
//

import Foundation
import TaskManagerPackage

/// Протокол репозитория
protocol IRepository {
	func getAllTasks() -> [Task]
}

/// Класс репозитория
final class Repository: IRepository {

	/// Получить все задачи
	func getAllTasks() -> [Task] {
		[
			RegularTask(title: "To clean the room"),
			RegularTask(title: "Learning English"),
			RegularTask(title: "Walk"),
			RegularTask(title: "To wash the dishes"),
			ImportantTask(title: "Workout", priority: .medium),
			ImportantTask(title: "To fix shoes", priority: .medium),
			ImportantTask(title: "Homework", priority: .high),
			ImportantTask(title: "Relax", priority: .high),
			ImportantTask(title: "To bake coockies and three cakes (for two lines in title)", priority: .low)
		]
	}
}

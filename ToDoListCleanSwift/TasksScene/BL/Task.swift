//
//  Task.swift
//  TodoList
//
//  Created by Evgeni Meleshin on 10.02.2023.
//

import Foundation

/// Класс задачи
class Task {
	
	/// Заголовок задачи
	var title: String
	/// Признак выполнения
	var completed: Bool
	/// Уникальный идентификатор
	var id: String
	
	init(title: String, completed: Bool = false) {
		self.completed = completed
		self.title = title
		self.id = String(describing: UUID())
	}
	
	/// Установка/снятие отметки выполнения
	func completeTask() {
		self.completed = !self.completed
	}
	
}

extension Task: Equatable {
	static func == (lhs: Task, rhs: Task) -> Bool {
		return(lhs.title == rhs.title && lhs.completed == rhs.completed)
	}
}

/// Класс обычноной задачи
class RegularTask: Task {}

/// Класс важной задачи
class ImportantTask: Task {
	
	/// Приоритет важности задачи
	var priority: ImportantTaskPriorities
	/// Дата выполнения задачи
	var completionDate: Date {
		return Calendar.current.date(byAdding: .day, value: priority.dayCountForCompletion, to: Date())!
	}
	init(title: String, priority: ImportantTaskPriorities) {
		self.priority = priority
		super.init(title: title)
	}
	
}

extension RegularTask: CustomStringConvertible {
	/// Описание обычной задачи
	var description: String {
		return "Title: \(title), completed: \(completed)"
	}
}

extension ImportantTask: CustomStringConvertible {
	/// Описание важной задачи
	var description: String {
		return "Title: \(title), completed: \(completed), priority: \(priority), date of completion: \(completionDate))"
	}
}

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
	var isCompleted: Bool

	init(title: String, isCompleted: Bool = false) {
		self.isCompleted = isCompleted
		self.title = title
	}

	/// Установка/снятие отметки выполнения
	func toggleCompletetionState() {
		isCompleted.toggle()
	}
}

extension Task: Equatable {
	static func == (lhs: Task, rhs: Task) -> Bool {
		return(lhs.title == rhs.title && lhs.isCompleted == rhs.isCompleted)
	}
}

/// Класс обычноной задачи
class RegularTask: Task {}

/// Класс важной задачи
class ImportantTask: Task {

	/// Приоритет важности задачи
	var priority: ImportantTaskPriority
	/// Дата выполнения задачи
	var completionDate: Date {
		return Calendar.current.date(byAdding: .day, value: priority.dayCountForCompletion, to: Date()) ?? Date()
	}
	init(title: String, priority: ImportantTaskPriority) {
		self.priority = priority
		super.init(title: title)
	}
}

extension RegularTask: CustomStringConvertible {
	/// Описание обычной задачи
	var description: String {
		return "Title: \(title), completed: \(isCompleted)"
	}
}

extension ImportantTask: CustomStringConvertible {
	/// Описание важной задачи
	var description: String {
		return "Title: \(title), completed: \(isCompleted), priority: \(priority), date of completion: \(completionDate))"
	}
}

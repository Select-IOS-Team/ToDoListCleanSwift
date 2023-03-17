//
//  Task.swift
//  TodoList
//
//  Created by Evgeni Meleshin on 10.02.2023.
//

import Foundation

/// Класс задачи
public class Task {

	/// Заголовок задачи
	public var title: String
	/// Признак выполнения
	public var isCompleted: Bool

	public init(title: String, isCompleted: Bool = false) {
		self.isCompleted = isCompleted
		self.title = title
	}

	/// Установка/снятие отметки выполнения
	public func toggleCompletetionState() {
		isCompleted.toggle()
	}
}

extension Task: Equatable {
	public static func == (lhs: Task, rhs: Task) -> Bool {
		return(lhs.title == rhs.title && lhs.isCompleted == rhs.isCompleted)
	}
}

/// Класс обычноной задачи
public final class RegularTask: Task {}

/// Класс важной задачи
public final class ImportantTask: Task {

	/// Приоритет важности задачи
	public var priority: ImportantTaskPriorities
	/// Дата выполнения задачи
	public var completionDate: Date {
		return Calendar.current.date(byAdding: .day, value: priority.dayCountForCompletion, to: Date()) ?? Date()
	}
	public init(title: String, priority: ImportantTaskPriorities) {
		self.priority = priority
		super.init(title: title)
	}
}

extension RegularTask: CustomStringConvertible {
	/// Описание обычной задачи
	public var description: String {
		return "Title: \(title), completed: \(isCompleted)"
	}
}

extension ImportantTask: CustomStringConvertible {
	/// Описание важной задачи
	public var description: String {
		return "Title: \(title), completed: \(isCompleted), priority: \(priority), date of completion: \(completionDate))"
	}
}

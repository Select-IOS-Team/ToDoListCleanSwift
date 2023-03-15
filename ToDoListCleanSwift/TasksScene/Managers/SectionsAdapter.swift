//
//  SectionsAdapter.swift
//  TodoList
//
//  Created by Evgeni Meleshin on 18.02.2023.
//

import Foundation
import TaskManagerPackage

/// Протокол типов секций
protocol ISectionsAdapter {
	func getSectionsTypes() -> [SectionsTypes]
	func getTasksForSectionsType(sectionType: SectionsTypes) -> [Task]
	func getSectionTypeAndIndex(task: Task) -> (sectionType: SectionsTypes, index: Int)?
	func getSectionTypeIndex(sectionType: SectionsTypes) -> Int
	func getSectionType(index: Int) -> SectionsTypes
}

/// Типы секций
enum SectionsTypes: Int, CustomStringConvertible, CaseIterable {

	case uncompletedTasks = 0
	case completedTasks = 1

	var description: String {
		switch self {
		case .uncompletedTasks:
			return "Невыполненные задачи"
		case .completedTasks:
			return "Выполненные задачи"
		}
	}
}

/// Класс типов секций
final class SectionAdapter: ISectionsAdapter {

	private let sectionsTypes: [SectionsTypes] = [.uncompletedTasks, .completedTasks]
	private let taskManager: ITaskManager

	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	func getSectionsTypes() -> [SectionsTypes] {
		sectionsTypes
	}

	func getTasksForSectionsType(sectionType: SectionsTypes) -> [Task] {
		switch sectionType {
		case .uncompletedTasks:
			return taskManager.uncompletedTasks()
		case .completedTasks:
			return taskManager.completedTasks()
		}
	}

	func getSectionTypeAndIndex(task: Task) -> (sectionType: SectionsTypes, index: Int)? {
		for sectionType in sectionsTypes {
			if let index = getTasksForSectionsType(sectionType: sectionType).firstIndex(where: { task === $0 }) {
				return (sectionType, index)
			}
		}
		return nil
	}

	func getSectionTypeIndex(sectionType: SectionsTypes) -> Int {
		sectionsTypes.firstIndex(of: sectionType) ?? 0
	}

	func getSectionType(index: Int) -> SectionsTypes {
		let indexSection = min(index, sectionsTypes.count - 1)
		return sectionsTypes[indexSection]
	}
}

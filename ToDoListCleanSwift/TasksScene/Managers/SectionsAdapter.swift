//
//  SectionsAdapter.swift
//  TodoList
//
//  Created by Evgeni Meleshin on 18.02.2023.
//

import Foundation
import ToDoListBusinessLogic

/// Протокол типов секций
protocol ISectionsAdapter {
	func getSectionsTypes() -> [SectionType]
	func getTasksForSectionsType(sectionType: SectionType) -> [Task]
	func getSectionTypeAndIndex(task: Task) -> (sectionType: SectionType, index: Int)?
	func getSectionTypeIndex(sectionType: SectionType) -> Int
	func getSectionType(index: Int) -> SectionType
}

/// Типы секций
enum SectionType: Int, CustomStringConvertible, CaseIterable {

	case uncompletedTasks = 0
	case completedTasks = 1

	var description: String {
		switch self {
		case .uncompletedTasks:
			return L10n.TasksScene.uncompletedTasks
		case .completedTasks:
			return L10n.TasksScene.completedTasks
		}
	}
}

/// Класс типов секций
final class SectionAdapter: ISectionsAdapter {

	private let sectionsTypes: [SectionType] = [.uncompletedTasks, .completedTasks]
	private let taskManager: ITaskManager

	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	func getSectionsTypes() -> [SectionType] {
		sectionsTypes
	}

	func getTasksForSectionsType(sectionType: SectionType) -> [Task] {
		switch sectionType {
		case .uncompletedTasks:
			return taskManager.uncompletedTasks()
		case .completedTasks:
			return taskManager.completedTasks()
		}
	}

	func getSectionTypeAndIndex(task: Task) -> (sectionType: SectionType, index: Int)? {
		for sectionType in sectionsTypes {
			if let index = getTasksForSectionsType(sectionType: sectionType).firstIndex(where: { task === $0 }) {
				return (sectionType, index)
			}
		}
		return nil
	}

	func getSectionTypeIndex(sectionType: SectionType) -> Int {
		sectionsTypes.firstIndex(of: sectionType) ?? 0
	}

	func getSectionType(index: Int) -> SectionType {
		let indexSection = min(index, sectionsTypes.count - 1)
		return sectionsTypes[indexSection]
	}
}

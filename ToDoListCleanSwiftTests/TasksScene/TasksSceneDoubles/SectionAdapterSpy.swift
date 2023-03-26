//
//  SectionAdapterSpy.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeni Meleshin on 26.03.2023.
//

import ToDoListBusinessLogic
@testable import ToDoListCleanSwift

final class SectionAdapterSpy: ISectionsAdapter {

	// MARK: - Internal Properties

	private (set) var getSectionsTypesIsCalled = false
	private (set) var getTasksForSectionsTypeIsCalled = false
	private (set) var getSectionTypeAndIndexIsCalled = false
	private (set) var getSectionTypeIndexIsCalled = false
	private (set) var getSectionTypeIsCalled = false

	private let taskManager: ITaskManager

	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	// MARK: - Internal Methods

	func getSectionsTypes() -> [SectionType] {
		getSectionsTypesIsCalled = true
		return [.uncompletedTasks, .completedTasks]
	}

	func getTasksForSectionsType(sectionType: SectionType) -> [Task] {
		getTasksForSectionsTypeIsCalled = true
		switch sectionType {
		case .uncompletedTasks:
			return taskManager.uncompletedTasks()
		case .completedTasks:
			return taskManager.completedTasks()
		}
	}

	func getSectionTypeAndIndex(task: Task) -> (sectionType: SectionType, index: Int)? {
		getSectionTypeAndIndexIsCalled = true
		return (sectionType: .uncompletedTasks, index: 0)
	}

	func getSectionTypeIndex(sectionType: SectionType) -> Int {
		getSectionTypeIndexIsCalled = true
		let sectionTypeIndex = 0
		return sectionTypeIndex
	}

	func getSectionType(index: Int) -> SectionType {
		getSectionTypeIsCalled = true
		return .uncompletedTasks
	}
}

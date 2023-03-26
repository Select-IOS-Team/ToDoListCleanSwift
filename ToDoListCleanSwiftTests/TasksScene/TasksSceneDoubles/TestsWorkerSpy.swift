//
//  TestsWorkerSpy.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeni Meleshin on 23.03.2023.
//

import ToDoListBusinessLogic
@testable import ToDoListCleanSwift

final class TasksWorkerSpy: ITasksWorker {

	// MARK: - Internal properties
	private (set) var convertIsCalled = false
	// swiftlint:disable: implicitly_unwrapped_optional
	var stubbedRequest: [(sectionType: SectionType, tasks: [Task])]!
	// swiftlint:enable: implicitly_unwrapped_optional
	var stubbedResponse = TaskModel.Response(data: [])

	// MARK: - Internal methods
	func convertToTaskModelResponse(data: [(sectionType: SectionType, tasks: [Task])]) -> TaskModel.Response {
		convertIsCalled = true
		stubbedRequest = data
		return stubbedResponse
	}
}

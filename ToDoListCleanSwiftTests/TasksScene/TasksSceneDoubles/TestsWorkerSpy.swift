//
//  TestsWorkerSpy.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeni Meleshin on 23.03.2023.
//

import ToDoListBusinessLogic
@testable import ToDoListCleanSwift

final class TasksWorkerSpy: ITasksWorker {

	// MARK: - Internal Properties
	private (set) var convertIsCalled = false

	// MARK: - Internal Methods
	func convertToTaskModelResponse(data: [(sectionType: SectionType, tasks: [Task])]) -> TaskModel.Response {
		convertIsCalled = true
		return ToDoListCleanSwift.TaskModel.Response(data: [])
	}
}

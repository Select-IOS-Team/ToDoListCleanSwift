//
//  TasksWorkerSpy.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeni Meleshin on 23.03.2023.
//

import ToDoListBusinessLogic
@testable import ToDoListCleanSwift

// swiftlint:disable identifier_name
// swiftlint:disable: implicitly_unwrapped_optional

final class TasksWorkerSpy: ITasksWorker {

	// MARK: - Internal properties

	var invokedConvertToTaskModelResponse = false
	var invokedConvertToTaskModelResponseCount = 0
	var invokedConvertToTaskModelResponseParameters: (data: [(sectionType: SectionType, tasks: [Task])], Void)?
	var invokedConvertToTaskModelResponseParametersList = [(data: [(sectionType: SectionType, tasks: [Task])], Void)]()
	var stubbedConvertToTaskModelResponseResult: TaskModel.Response!

	// MARK: - ITasksWorker

	func convertToTaskModelResponse(data: [(sectionType: SectionType, tasks: [Task])]) -> TaskModel.Response {
		invokedConvertToTaskModelResponse = true
		invokedConvertToTaskModelResponseCount += 1
		invokedConvertToTaskModelResponseParameters = (data, ())
		invokedConvertToTaskModelResponseParametersList.append((data, ()))
		return stubbedConvertToTaskModelResponseResult
	}
}

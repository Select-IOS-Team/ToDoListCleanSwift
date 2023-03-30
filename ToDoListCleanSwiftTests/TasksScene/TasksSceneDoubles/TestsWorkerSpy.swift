//
//  TestsWorkerSpy.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeni Meleshin on 23.03.2023.
//

import ToDoListBusinessLogic
@testable import ToDoListCleanSwift

final class TasksWorkerSpy: ITasksWorker {

	var invokedConvertToTaskModelResponse = false
	var invokedConvertToTaskModelResponseCount = 0
	// swiftlint:disable identifier_name
	var invokedConvertToTaskModelResponseParameters: (data: [(sectionType: SectionType, tasks: [Task])], Void)?
	var invokedConvertToTaskModelResponseParametersList = [(data: [(sectionType: SectionType, tasks: [Task])], Void)]()
	// swiftlint:enable identifier_name
	// swiftlint:disable: implicitly_unwrapped_optional
	var stubbedConvertToTaskModelResponseResult: TaskModel.Response!
	// swiftlint:enable: implicitly_unwrapped_optional

	func convertToTaskModelResponse(data: [(sectionType: SectionType, tasks: [Task])]) -> TaskModel.Response {
		invokedConvertToTaskModelResponse = true
		invokedConvertToTaskModelResponseCount += 1
		invokedConvertToTaskModelResponseParameters = (data, ())
		invokedConvertToTaskModelResponseParametersList.append((data, ()))
		return stubbedConvertToTaskModelResponseResult
	}
}

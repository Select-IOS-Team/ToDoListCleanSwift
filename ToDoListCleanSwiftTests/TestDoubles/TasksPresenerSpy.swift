//
//  TasksPresenerSpy.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeni Meleshin on 23.03.2023.
//

@testable import ToDoListCleanSwift

final class TasksPresenterSpy: ITasksPresenter {

	// MARK: - Internal properties

	var invokedPresentData = false
	var invokedPresentDataCount = 0
	var invokedPresentDataParameters: (response: TaskModel.Response, Void)?
	var invokedPresentDataParametersList = [(response: TaskModel.Response, Void)]()

	// MARK: - ITasksPresenter

	func presentData(response: TaskModel.Response) {
		invokedPresentData = true
		invokedPresentDataCount += 1
		invokedPresentDataParameters = (response, ())
		invokedPresentDataParametersList.append((response, ()))
	}
}

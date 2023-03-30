//
//  TasksInteractorSpy.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeni Meleshin on 24.03.2023.
//

@testable import ToDoListCleanSwift
import Foundation

final class TasksInteractorSpy: ITasksInteractor {

	var invokedDidCheckboxTapped = false
	var invokedDidCheckboxTappedCount = 0
	var invokedDidCheckboxTappedParameters: (indexPath: IndexPath, Void)?
	var invokedDidCheckboxTappedParametersList = [(indexPath: IndexPath, Void)]()

	func didCheckboxTapped(indexPath: IndexPath) {
		invokedDidCheckboxTapped = true
		invokedDidCheckboxTappedCount += 1
		invokedDidCheckboxTappedParameters = (indexPath, ())
		invokedDidCheckboxTappedParametersList.append((indexPath, ()))
	}

	var invokedFetchData = false
	var invokedFetchDataCount = 0

	func fetchData() {
		invokedFetchData = true
		invokedFetchDataCount += 1
	}
}

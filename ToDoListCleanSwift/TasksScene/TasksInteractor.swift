//
//  TasksInteractor.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//

import Foundation
import TaskManagerPackage

/// Протокол интерактора
protocol ITasksInteractor: AnyObject {
	func didCheckboxTapped(indexPath: IndexPath)
	func fetchData()
}

/// Класс интерактора
class TasksInteractor: ITasksInteractor {

	var sectionsAdapter: ISectionsAdapter?
	var presenter: ITasksPresenter?
	var worker: ITasksWorker?

	func fetchData() {
		var result: [(section: SectionsTypes, tasks: [Task])] = []
		guard let sectionsTypes = sectionsAdapter?.getSectionsTypes() else { return }
		for sectionsType in sectionsTypes {
			guard let sectionTasks = sectionsAdapter?.getTasksForSectionsType(sectionType: sectionsType) else { return }
			result.append((section: sectionsType, tasks: sectionTasks))
		}
		guard let response = worker?.fillResponse(result: result) else { return }
		presenter?.presentData(response: response)
	}

	func didCheckboxTapped(indexPath: IndexPath) {
		guard let sectionType = sectionsAdapter?.getSectionType(index: indexPath.section) else { return }
		guard let task = sectionsAdapter?.getTasksForSectionsType(sectionType: sectionType)[indexPath.row] else { return }
		task.toggleCompletetionState()
		fetchData()
	}
}

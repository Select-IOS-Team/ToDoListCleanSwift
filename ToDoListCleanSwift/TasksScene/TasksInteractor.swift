//
//  TasksInteractor.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//

import Foundation
import ToDoListBusinessLogic

/// Интерактор сцены списка задач
protocol ITasksInteractor: AnyObject {
	/// Получает задачу по индексу и выполняет/отменяет ее
	/// - Parameter indexPath: `indexPath` отмеченной задачи в списке
	func didCheckboxTapped(indexPath: IndexPath)
	/// Получает секции и задачи в них и преобразует в `TaskModel.Response` для презентера
	func fetchData()
}

/// Класс интерактора
class TasksInteractor: ITasksInteractor {

	private let sectionsAdapter: ISectionsAdapter?
	private let presenter: ITasksPresenter?
	private let worker: ITasksWorker?

	init(sectionsAdapter: ISectionsAdapter, presenter: ITasksPresenter, worker: ITasksWorker) {
		self.sectionsAdapter = sectionsAdapter
		self.presenter = presenter
		self.worker = worker
	}

	func fetchData() {
		var data: [(sectionType: SectionType, tasks: [Task])] = []
		guard let sectionsTypes = sectionsAdapter?.getSectionsTypes() else { return }
		for sectionsType in sectionsTypes {
			guard let sectionTasks = sectionsAdapter?.getTasksForSectionsType(sectionType: sectionsType) else { return }
			data.append((sectionType: sectionsType, tasks: sectionTasks))
		}
		guard let response = worker?.convertToTaskModelResponse(data: data) else { return }
		presenter?.presentData(response: response)
	}

	func didCheckboxTapped(indexPath: IndexPath) {
		guard let sectionType = sectionsAdapter?.getSectionType(index: indexPath.section) else { return }
		guard let task = sectionsAdapter?.getTasksForSectionsType(sectionType: sectionType)[indexPath.row] else { return }
		task.toggleCompletetionState()
		fetchData()
	}
}

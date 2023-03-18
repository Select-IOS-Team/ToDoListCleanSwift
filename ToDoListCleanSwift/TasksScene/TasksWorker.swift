//
//  TasksWorker.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//

import Foundation

/// Протокол воркера
protocol ITasksWorker {
	func fillResponse(result: [(section: SectionsTypes, tasks: [Task])]) -> TaskModel.Response
}

/// Класс воркера
class TasksWorker: ITasksWorker {

	func fillResponse(result: [(section: SectionsTypes, tasks: [Task])]) -> TaskModel.Response {
		var response = TaskModel.Response(data: [])
		for item in result {
			response.data.append(TaskModel.ResponseData(sectionType: item.section, sectionTasks: item.tasks))
		}
		return response
	}
}

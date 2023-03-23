//
//  TasksWorker.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//

import Foundation
import ToDoListBusinessLogic

/// Воркер, подготавливающий модели данных о секциях и задачах для презентера
protocol ITasksWorker {
	/// Преобразует данные о секциях и из задачах из массива кортежей в модель `TaskModel.Response`.
	/// - Parameter data: Массив кортежей с параметрами: `sectionType` - тип секции и `tasks` - массив задач в секции
	/// - Returns: Модель `TaskModel.Response`, содержащая переданные на вход данные
	func convertToTaskModelResponse(data: [(sectionType: SectionType, tasks: [Task])]) -> TaskModel.Response
}

/// Класс воркера
class TasksWorker: ITasksWorker {

	func convertToTaskModelResponse(data: [(sectionType: SectionType, tasks: [Task])]) -> TaskModel.Response {
		var response = TaskModel.Response(data: [])
		for item in data {
			response.data.append(TaskModel.ResponseData(sectionType: item.sectionType, sectionTasks: item.tasks))
		}
		return response
	}
}

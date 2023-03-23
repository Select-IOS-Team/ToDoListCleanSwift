//
//  TasksModel.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//
import Foundation
import ToDoListBusinessLogic

/// Модель вью
enum TaskModel {

	struct Response {
		var data: [ResponseData]
	}

	struct ResponseData: Equatable {
		let sectionType: SectionType
		let sectionTasks: [Task]
	}

	struct ViewData {
		struct RegularTask {
			let title: String
			let checkboxImageName: String
		}
		struct ImportantTask {
			let title: String
			let checkboxImageName: String
			let isExpired: Bool
			let priorityText: String
			let executionDate: String
		}
		enum Task {
			case regularTask(RegularTask)
			case importantTask(ImportantTask)
		}
		struct Section {
			let title: String
			let tasks: [Task]
		}
		let tasksBySections: [Section]
	}
}

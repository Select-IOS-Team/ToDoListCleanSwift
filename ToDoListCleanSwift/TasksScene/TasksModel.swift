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

	struct Response: Equatable {
		var data: [ResponseData]
	}

	struct ResponseData: Equatable {
		let sectionType: SectionType
		let sectionTasks: [Task]
	}

	struct ViewData: Equatable {

		struct RegularTask: Equatable {
			let title: String
			let checkboxImageName: String
		}
		struct ImportantTask: Equatable {
			let title: String
			let checkboxImageName: String
			let isExpired: Bool
			let priorityText: String
			let executionDate: String
		}
		enum Task: Equatable {
			case regularTask(RegularTask)
			case importantTask(ImportantTask)
		}
		struct Section: Equatable {
			let title: String
			let tasks: [Task]
		}
		let tasksBySections: [Section]
	}
}

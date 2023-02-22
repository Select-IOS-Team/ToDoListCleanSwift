//
//  TasksModels.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//
import Foundation

/// Модель вью
enum TaskModel {
	
	enum Request {
		case data
	}
	
	struct Response {
		var data: [ResponseData]
	}
	
	struct ResponseData {
		let sectionType: SectionsTypes
		let sectionTasks: [Task]
	}
	
	struct ViewData {
		struct RegularLask {
			let title: String
			let completed: Bool
		}
		struct ImportantTask {
			let title: String
			let completed: Bool
			let priority: String
			let completionDate: String
			let overdue: Bool
		}
		enum Task {
			case regularTask(RegularLask)
			case importantTask(ImportantTask)
			
		}
		struct Section {
			let title: String
			let tasks: [Task]
		}
		let tasksBySections: [Section]
	}
}

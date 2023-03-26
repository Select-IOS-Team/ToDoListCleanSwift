//
//  LoginModels.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//

import Foundation

enum LoginModels {
	struct Request {
		var login: String
		var password: String
	}
	struct Response {
		var success: Bool
		var login: String
	}
	struct ViewModel {
		var success: Bool
		var userName: String
	}
}

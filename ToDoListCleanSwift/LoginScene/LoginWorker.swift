//
//  LoginWorker.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//

import Foundation

public struct LoginDTO {
	var success: Int
	var login: String
	var lastLoginDate: Date
}

protocol ILoginWorker {
	func login(login: String, password: String) -> LoginDTO
}

class LoginWorker: ILoginWorker {

	func login(login: String, password: String) -> LoginDTO {
		guard login == "1" && password == "1" else {
			return LoginDTO(success: 0, login: login, lastLoginDate: Date())
		}
		return LoginDTO(success: 1, login: login, lastLoginDate: Date())
	}
}

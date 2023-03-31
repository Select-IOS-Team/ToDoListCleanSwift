//
//  LoginWorker.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//

import Foundation

/// Данные для ответа
public struct LoginDTO: Equatable {
	var success: Int
	var login: String
}

protocol ILoginWorker {
	func login(login: String, password: String) -> LoginDTO
}

class LoginWorker: ILoginWorker {

	func login(login: String, password: String) -> LoginDTO {
		guard login == "" && password == "" else {
			return LoginDTO(success: 0, login: login)
		}
		return LoginDTO(success: 1, login: login)
	}
}

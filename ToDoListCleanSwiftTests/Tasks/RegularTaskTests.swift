//
//  RegularTaskTests.swift
//  RegularTaskTests
//
//  Created by Evgeni Meleshin on 10.03.2023.
//

import Foundation
import XCTest
@testable import ToDoListCleanSwift

/// Класс тестов для обычной задачи
final class RegularTaskTests: XCTestCase {
	
	// После вызова метода значение должно быть инвертировано
	func test_regularTask_completedShouldBeTrue() {
		
		// arrange
		let sut = RegularTask(title: "Regular task example")
		
		// act
		let startState = sut.completed
		sut.completeTask()
		let endState = sut.completed
		
		// assert
		XCTAssertNotEqual(startState, endState, "Values should not be equals")
	}

}

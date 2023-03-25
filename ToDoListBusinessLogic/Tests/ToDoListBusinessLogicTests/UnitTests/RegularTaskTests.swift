//
//  RegularTaskTests.swift
//  ToDoListBusinessLogicTests
//
//  Created by Evgeni Meleshin on 10.03.2023.
//

import Foundation
import XCTest
@testable import ToDoListBusinessLogic

/// Класс тестов для обычной задачи
final class RegularTaskTests: XCTestCase {

	// После вызова метода toggleCompletetionState невыполненная задача должна стать выполненной
	func test_toggleCompletetionState_uncompletedTask_afterCompletedShouldBeTrue() {

		// arrange
		let sut = RegularTask(title: "Regular task example")

		// act
		let startState = sut.isCompleted
		sut.toggleCompletetionState()
		let endState = sut.isCompleted

		// assert
		XCTAssertNotEqual(startState, endState, "Values should not be equals")
	}
}

//
//  SectionAdapterSpy.swift
//  ToDoListCleanSwiftTests
//
//  Created by Evgeni Meleshin on 26.03.2023.
//

import ToDoListBusinessLogic
@testable import ToDoListCleanSwift

// swiftlint:disable identifier_name
// swiftlint:disable implicitly_unwrapped_optional

final class SectionAdapterSpy: ISectionsAdapter {

	// MARK: - Internal properties

	var invokedGetSectionsTypes = false
	var invokedGetSectionsTypesCount = 0
	var stubbedGetSectionsTypesResult: [SectionType] = []

	var invokedGetTasksForSectionsType = false
	var invokedGetTasksForSectionsTypeCount = 0
	var invokedGetTasksForSectionsTypeParameters: (sectionType: SectionType, Void)?
	var invokedGetTasksForSectionsTypeParametersList = [(sectionType: SectionType, Void)]()
	var stubbedGetTasksForSectionsTypeResult: [Task] = []

	var invokedGetSectionTypeAndIndex = false
	var invokedGetSectionTypeAndIndexCount = 0
	var invokedGetSectionTypeAndIndexParameters: (task: Task, Void)?
	var invokedGetSectionTypeAndIndexParametersList = [(task: Task, Void)]()
	var stubbedGetSectionTypeAndIndexResult: (sectionType: SectionType, index: Int)!

	var invokedGetSectionTypeIndex = false
	var invokedGetSectionTypeIndexCount = 0
	var invokedGetSectionTypeIndexParameters: (sectionType: SectionType, Void)?
	var invokedGetSectionTypeIndexParametersList = [(sectionType: SectionType, Void)]()
	var stubbedGetSectionTypeIndexResult: Int = 0

	var invokedGetSectionType = false
	var invokedGetSectionTypeCount = 0
	var invokedGetSectionTypeParameters: (index: Int, Void)?
	var invokedGetSectionTypeParametersList = [(index: Int, Void)]()
	var stubbedGetSectionTypeResult: SectionType!

	// MARK: - ISectionsAdapter

	func getSectionsTypes() -> [SectionType] {
		invokedGetSectionsTypes = true
		invokedGetSectionsTypesCount += 1
		return stubbedGetSectionsTypesResult
	}

	func getTasksForSectionsType(sectionType: SectionType) -> [Task] {
		invokedGetTasksForSectionsType = true
		invokedGetTasksForSectionsTypeCount += 1
		invokedGetTasksForSectionsTypeParameters = (sectionType, ())
		invokedGetTasksForSectionsTypeParametersList.append((sectionType, ()))
		return stubbedGetTasksForSectionsTypeResult
	}

	func getSectionTypeAndIndex(task: Task) -> (sectionType: SectionType, index: Int)? {
		invokedGetSectionTypeAndIndex = true
		invokedGetSectionTypeAndIndexCount += 1
		invokedGetSectionTypeAndIndexParameters = (task, ())
		invokedGetSectionTypeAndIndexParametersList.append((task, ()))
		return stubbedGetSectionTypeAndIndexResult
	}

	func getSectionTypeIndex(sectionType: SectionType) -> Int {
		invokedGetSectionTypeIndex = true
		invokedGetSectionTypeIndexCount += 1
		invokedGetSectionTypeIndexParameters = (sectionType, ())
		invokedGetSectionTypeIndexParametersList.append((sectionType, ()))
		return stubbedGetSectionTypeIndexResult
	}

	func getSectionType(index: Int) -> SectionType {
		invokedGetSectionType = true
		invokedGetSectionTypeCount += 1
		invokedGetSectionTypeParameters = (index, ())
		invokedGetSectionTypeParametersList.append((index, ()))
		return stubbedGetSectionTypeResult
	}
}

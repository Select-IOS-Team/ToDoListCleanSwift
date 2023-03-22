// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "ToDoListBusinessLogic",
	platforms: [
		.iOS(.v15)
	],
	products: [
		.library(
			name: "ToDoListBusinessLogic",
			targets: ["ToDoListBusinessLogic"]
		)
	],
	dependencies: [],
	targets: [
		.target(
			name: "ToDoListBusinessLogic",
			dependencies: []
		),
		.testTarget(
			name: "ToDoListBusinessLogicTests",
			dependencies: ["ToDoListBusinessLogic"]
		)
	]
)

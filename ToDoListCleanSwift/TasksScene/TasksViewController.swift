//
//  TasksViewController.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//

import UIKit

/// Протокол контроллера задач
protocol ITasksViewController: AnyObject {
	func render(viewData: TaskModel.ViewData)
}

/// Класс контроллера задач
final class TasksViewController: UIViewController {

	var interactor: ITasksInteractor?
	var viewData: TaskModel.ViewData = TaskModel.ViewData(tasksBySections: [])
	let tasksTableView = UITableView()

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "To-do List"
		setupTableView()
		setupTableViewConstraints()
		interactor?.fetchData()
	}

	private func setupTableView() {
		tasksTableView.translatesAutoresizingMaskIntoConstraints = false
		tasksTableView.dataSource = self
		tasksTableView.backgroundColor = .white
		tasksTableView.registerCell(type: RegularTaskTableViewCell.self)
		tasksTableView.registerCell(type: ImportantTaskTableViewCell.self)
		view.addSubview(tasksTableView)
	}

	private func setupTableViewConstraints() {
		tasksTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
		tasksTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
		tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
	}
}

extension TasksViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let section = viewData.tasksBySections[section]
		return section.tasks.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let sectionTasks = viewData.tasksBySections[indexPath.section].tasks
		let taskData = sectionTasks[indexPath.row]

		switch taskData {
		case .importantTask(let model):
			guard let cell = tableView.dequeue(
				type: ImportantTaskTableViewCell.self,
				for: indexPath
			) else { return UITableViewCell() }

			cell.configure(with: model)
			cell.completionCheckboxTapAction = { [weak self] in
				guard let self = self else { return }
				self.interactor?.didCheckboxTapped(indexPath: indexPath)
			}
			return cell
		case .regularTask(let model):
			guard let cell = tableView.dequeue(
				type: RegularTaskTableViewCell.self,
				for: indexPath
			) else { return UITableViewCell() }

			cell.configure(with: model)
			cell.completionCheckboxTapAction = { [weak self] in
				guard let self = self else { return }
				self.interactor?.didCheckboxTapped(indexPath: indexPath)
			}
			return cell
		}
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		viewData.tasksBySections.count
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		viewData.tasksBySections[section].title
	}
}

extension TasksViewController: ITasksViewController {

	func render(viewData: TaskModel.ViewData) {
		self.viewData = viewData
		tasksTableView.reloadData()
	}
}

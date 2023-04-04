//
//  TasksViewController.swift
//  ToDoListCleanSwift
//
//  Created by Evgeni Meleshin on 21.02.2023.
//

import PinLayout
import UIKit

/// Вью контроллер сцены списка задач.
protocol ITasksViewController: AnyObject {
	/// Отображает данные, соответствующие переданной модели.
	func render(viewData: TaskModel.ViewData)
}

/// Вью контроллер сцены списка задач.
final class TasksViewController: UIViewController {

	// MARK: - Internal properties

	var interactor: ITasksInteractor?
	var viewData: TaskModel.ViewData = TaskModel.ViewData(tasksBySections: [])
	private lazy var tasksTableView = makeTableView()

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		interactor?.fetchData()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		tasksTableView.pin.all()
	}
}

// MARK: - ITasksViewController

extension TasksViewController: ITasksViewController {

	func render(viewData: TaskModel.ViewData) {
		self.viewData = viewData
		tasksTableView.reloadData()
	}
}

// MARK: - UITableViewDataSource

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

// MARK: - Private methods

private extension TasksViewController {

	func makeTableView() -> UITableView {
		let tableView = UITableView()
		tableView.registerCell(type: RegularTaskTableViewCell.self)
		tableView.registerCell(type: ImportantTaskTableViewCell.self)
		tableView.dataSource = self
		return tableView
	}

	func setupUI() {
		view.addSubview(tasksTableView)
	}
}

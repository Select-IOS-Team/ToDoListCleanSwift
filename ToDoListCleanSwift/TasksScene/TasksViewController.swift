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

	// MARK: - Private properties

	private let interactor: ITasksInteractor?
	private lazy var tasksTableView = makeTableView()

	// MARK: - Internal properties

	var viewData: TaskModel.ViewData = TaskModel.ViewData(tasksBySections: [])

	// MARK: - Lifecycle

	init(interactor: ITasksInteractor) {
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

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
			cell.accessibilityIdentifier = "\(AccessibilityIdentifier.cell.rawValue)-\(indexPath.section)-\(indexPath.row)"
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
			cell.accessibilityIdentifier = "\(AccessibilityIdentifier.cell.rawValue)-\(indexPath.section)-\(indexPath.row)"
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

// MARK: - UITableViewDelegate

extension TasksViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = UIView()
		let sectionLabel = UILabel()
		sectionLabel.text = viewData.tasksBySections[section].title
		sectionLabel.textColor = .systemGray
		sectionLabel.sizeToFit()
		sectionLabel.pin
			.vCenter()
			.start(16)
		sectionLabel.accessibilityIdentifier = "\(AccessibilityIdentifier.sectionLabel.rawValue)-\(section)"
		headerView.addSubview(sectionLabel)
		headerView.accessibilityIdentifier = "\(AccessibilityIdentifier.section.rawValue)-\(section)"
		return headerView
	}
}

// MARK: - Private methods

private extension TasksViewController {

	func makeTableView() -> UITableView {
		let tableView = UITableView()
		tableView.registerCell(type: RegularTaskTableViewCell.self)
		tableView.registerCell(type: ImportantTaskTableViewCell.self)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.accessibilityIdentifier = AccessibilityIdentifier.tasksTableView.rawValue
		return tableView
	}

	func setupUI() {
		view.addSubview(tasksTableView)
	}
}

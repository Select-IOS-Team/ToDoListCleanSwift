//
//  TaskViewCell.swift
//  TodoList
//
//  Created by Evgeni Meleshin on 11.02.2023.
//

import UIKit

// Класс ячейки
final class TaskViewCell: UITableViewCell {

	var title = UILabel()
	var priority = UILabel()
	let checkbox = CheckboxButton(frame: CGRect(x: 20, y: 20, width: 50, height: 50))
	var completionDate = UILabel()
	let mainStackView = UIStackView()
	let detailsStackView = UIStackView()
	var completeAction: (() -> Void)?

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configureCell()
		setupConstraints()
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		completeAction = nil
		title.text = nil
		priority.text = nil
		checkbox.isChecked = false
	}

	private func configureCell() {
		let gesture = UITapGestureRecognizer(target: self, action: #selector(didTappedCheckbox))
		checkbox.addGestureRecognizer(gesture)
		contentView.isUserInteractionEnabled = false

		priority.textAlignment = .right
		completionDate.textAlignment = .right

		mainStackView.translatesAutoresizingMaskIntoConstraints = false
		mainStackView.axis = .vertical
		mainStackView.spacing = 8

		detailsStackView.translatesAutoresizingMaskIntoConstraints = false
		detailsStackView.axis = .horizontal
		detailsStackView.addArrangedSubview(title)
		detailsStackView.addArrangedSubview(checkbox)
		checkbox.centerYAnchor.constraint(equalTo: title.centerYAnchor).isActive = true

		addSubview(mainStackView)
		mainStackView.addArrangedSubview(priority)
		mainStackView.addArrangedSubview(detailsStackView)
		mainStackView.addArrangedSubview(completionDate)
	}

	private func setupConstraints() {
		checkbox.heightAnchor.constraint(equalToConstant: 30).isActive = true
		checkbox.widthAnchor.constraint(equalToConstant: 30).isActive = true

		detailsStackView.topAnchor.constraint(equalTo: priority.bottomAnchor).isActive = true
		detailsStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor).isActive = true
		detailsStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor).isActive = true
		detailsStackView.bottomAnchor.constraint(equalTo: completionDate.topAnchor).isActive = true
		detailsStackView.alignment = .center

		title.leadingAnchor.constraint(equalTo: detailsStackView.leadingAnchor, constant: 20).isActive = true

		mainStackView.heightAnchor.constraint(equalToConstant: 70).isActive = true
		mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
		mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
		mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
		mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	@objc func didTappedCheckbox() {
		checkbox.toggle()
		guard let action = completeAction else { return }
		action()
	}
}

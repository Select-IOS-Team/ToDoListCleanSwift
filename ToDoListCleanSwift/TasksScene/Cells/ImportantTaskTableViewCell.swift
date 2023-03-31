//
//  ImportantTaskTableViewCell.swift
//  ToDoList
//
//  Created by Evgeniy Novgorodov on 12.02.2023.
//

import UIKit
import PinLayout

/// Ячейка важной задачи.
final class ImportantTaskTableViewCell: UITableViewCell {

	// MARK: - Nested types

	private enum Constants {
		static let titleLabelNumberOfLines: Int = 2
		static let expiredTaskBackgroundColor: UIColor = .red.withAlphaComponent(0.2)
		static let unexpiredTaskBackgroundColor: UIColor = .white
		static let additionalTextColor: UIColor = .darkGray
		static let contentVerticalInset: CGFloat = 12
		static let contentHorizontalInset: CGFloat = 16
		static let contentSpace: CGFloat = 12
		static let checkboxImageViewSize: CGFloat = 32
	}

	typealias ConfigurationModel = TaskModel.ViewData.ImportantTask

	// MARK: - Internal properties

	var completionCheckboxTapAction: (() -> Void)?

	// MARK: - Private properties

	private lazy var completionCheckboxImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.isUserInteractionEnabled = true
		return imageView
	}()
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = Constants.titleLabelNumberOfLines
		return label
	}()
	private lazy var priorityLabel: UILabel = {
		let label = UILabel()
		label.textColor = Constants.additionalTextColor
		return label
	}()
	private lazy var executionDateLabel: UILabel = {
		let label = UILabel()
		label.textColor = Constants.additionalTextColor
		return label
	}()

	// MARK: - Lifecycle

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
		setupLayout()
		configureUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		completionCheckboxImageView.image = nil
		titleLabel.text = nil
		priorityLabel.text = nil
		executionDateLabel.text = nil
	}
}

// MARK: - IConfigurableTableCell

extension ImportantTaskTableViewCell: IConfigurableTableCell {

	func configure(with model: ConfigurationModel) {
		titleLabel.text = model.title
		completionCheckboxImageView.image = UIImage(systemName: model.checkboxImageName)
		priorityLabel.text = model.priorityText
		executionDateLabel.text = model.executionDate
		contentView.backgroundColor = model.isExpired
			? Constants.expiredTaskBackgroundColor
			: Constants.unexpiredTaskBackgroundColor
	}
}

// MARK: - Private methods

private extension ImportantTaskTableViewCell {

	func setupUI() {
		contentView.addSubview(titleLabel)
		contentView.addSubview(completionCheckboxImageView)
		contentView.addSubview(priorityLabel)
		contentView.addSubview(executionDateLabel)

		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCheckbox))
		tapGestureRecognizer.isEnabled = true
		completionCheckboxImageView.addGestureRecognizer(tapGestureRecognizer)
	}

	func setupLayout() {
//		NSLayoutConstraint.activate([
//			completionCheckboxImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//			completionCheckboxImageView.leadingAnchor.constraint(
//				equalTo: contentView.leadingAnchor,
//				constant: Constants.contentHorizontalInset
//			),
//			completionCheckboxImageView.widthAnchor.constraint(equalToConstant: Constants.checkboxImageViewSize),
//			completionCheckboxImageView.heightAnchor.constraint(equalToConstant: Constants.checkboxImageViewSize),
//
//			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.contentVerticalInset),
//			titleLabel.leadingAnchor.constraint(
//				equalTo: completionCheckboxImageView.trailingAnchor,
//				constant: Constants.contentSpace
//			),
//			titleLabel.trailingAnchor.constraint(
//				equalTo: contentView.trailingAnchor,
//				constant: -Constants.contentHorizontalInset
//			),
//
//			priorityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.contentSpace),
//			priorityLabel.leadingAnchor.constraint(
//				equalTo: completionCheckboxImageView.trailingAnchor,
//				constant: Constants.contentSpace
//			),
//			priorityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.contentVerticalInset),
//
//			executionDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.contentSpace),
//			executionDateLabel.leadingAnchor.constraint(equalTo: priorityLabel.trailingAnchor, constant: Constants.contentSpace),
//			executionDateLabel.trailingAnchor.constraint(
//				equalTo: contentView.trailingAnchor,
//				constant: -Constants.contentHorizontalInset
//			),
//			executionDateLabel.bottomAnchor.constraint(
//				equalTo: contentView.bottomAnchor,
//				constant: -Constants.contentVerticalInset
//			)
//		])
//		executionDateLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

		completionCheckboxImageView.pin
			.start(Constants.contentHorizontalInset)
			.size(Constants.checkboxImageViewSize)
			.vCenter()

		titleLabel.pin
			.top()
			.after(of: completionCheckboxImageView)
			.marginHorizontal(Constants.contentSpace)
			.width(of: contentView)
			.height(45%)

		priorityLabel.pin
			.below(of: titleLabel)
			.marginHorizontal(Constants.contentSpace)
			.height(45%)

		executionDateLabel.pin
			.after(of: priorityLabel)
	}

	func configureUI() {
		selectionStyle = .none
	}

	@objc
	func didTapCheckbox() {
		completionCheckboxTapAction?()
	}
}

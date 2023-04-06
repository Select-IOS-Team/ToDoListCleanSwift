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
		static let checkboxTintColor = Palette.main
		static let expiredTaskBackgroundColor = Palette.accentWarning
		static let unexpiredTaskBackgroundColor = UIColor.clear
		static let additionalTextColor = Palette.additionalText
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
		imageView.tintColor = Constants.checkboxTintColor
		imageView.accessibilityIdentifier = AccessibilityIdentifier.checkBoxImportantTask.rawValue
		return imageView
	}()
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = Constants.titleLabelNumberOfLines
		label.accessibilityIdentifier = AccessibilityIdentifier.titleLabelImportantTask.rawValue
		return label
	}()
	private lazy var priorityLabel: UILabel = {
		let label = UILabel()
		label.textColor = Constants.additionalTextColor
		label.accessibilityIdentifier = AccessibilityIdentifier.priorityLabel.rawValue
		return label
	}()
	private lazy var executionDateLabel: UILabel = {
		let label = UILabel()
		label.textColor = Constants.additionalTextColor
		label.accessibilityIdentifier = AccessibilityIdentifier.executionDateLabel.rawValue
		return label
	}()

	// MARK: - Lifecycle

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
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

	override func layoutSubviews() {
		super.layoutSubviews()
		setupLayout()
	}

	override func sizeThatFits(_ size: CGSize) -> CGSize {
		setupLayout()
		let height = titleLabel.frame.height + max(priorityLabel.frame.height, executionDateLabel.frame.height)
		+ Constants.contentSpace + 2 * Constants.contentVerticalInset
		return CGSize(width: contentView.frame.width, height: height)
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
		completionCheckboxImageView.pin
			.vCenter()
			.start(Constants.contentHorizontalInset)
			.size(Constants.checkboxImageViewSize)

		titleLabel.pin
			.after(of: completionCheckboxImageView)
			.topEnd()
			.sizeToFit(.width)
			.marginTop(Constants.contentVerticalInset)
			.marginStart(Constants.contentSpace)
			.marginEnd(Constants.contentHorizontalInset)

		priorityLabel.pin
			.topStart(to: titleLabel.anchor.bottomStart)
			.before(of: executionDateLabel)
			.sizeToFit(.width)
			.marginTop(Constants.contentSpace)
			.marginEnd(Constants.contentSpace)

		executionDateLabel.pin
			.topEnd(to: titleLabel.anchor.bottomEnd)
			.bottom()
			.sizeToFit(.widthFlexible)
			.marginTop(Constants.contentSpace)
			.marginBottom(Constants.contentVerticalInset)
	}

	func configureUI() {
		selectionStyle = .none
	}

	@objc
	func didTapCheckbox() {
		completionCheckboxTapAction?()
	}
}

//
//  RegularTaskTableViewCell.swift
//  ToDoList
//
//  Created by Evgeniy Novgorodov on 12.02.2023.
//

import UIKit
import PinLayout

/// Ячейка обычной задачи.
final class RegularTaskTableViewCell: UITableViewCell {

	// MARK: - Nested types

	private enum Constants {
		static let titleLabelNumberOfLines: Int = 2
		static let contentViewHeight: CGFloat = 56
		static let contentHorizontalInset: CGFloat = 16
		static let contentSpace: CGFloat = 12
		static let checkboxImageViewSize: CGFloat = 32
	}

	typealias ConfigurationModel = TaskModel.ViewData.RegularTask

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
	}
}

// MARK: - IConfigurableTableCell

extension RegularTaskTableViewCell: IConfigurableTableCell {

	func configure(with model: ConfigurationModel) {
		titleLabel.text = model.title
		completionCheckboxImageView.image = UIImage(systemName: model.checkboxImageName)
	}
}

// MARK: - Private methods

private extension RegularTaskTableViewCell {

	func setupUI() {
		contentView.addSubview(titleLabel)
		contentView.addSubview(completionCheckboxImageView)

		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCheckbox))
		tapGestureRecognizer.isEnabled = true
		completionCheckboxImageView.addGestureRecognizer(tapGestureRecognizer)
	}

	func setupLayout() {
		contentView.pin.minHeight(Constants.contentViewHeight)

		completionCheckboxImageView.pin
			.start(Constants.contentHorizontalInset)
			.size(Constants.checkboxImageViewSize)
			.vCenter()
			.marginBottom((Constants.contentViewHeight - Constants.checkboxImageViewSize) / 4)

		titleLabel.pin
			.vCenter()
			.after(of: completionCheckboxImageView)
			.marginHorizontal(Constants.contentSpace)
			.width(of: contentView)
			.height(75%)
			.marginBottom((Constants.contentViewHeight - Constants.checkboxImageViewSize) / 4)
	}

	func configureUI() {
		selectionStyle = .none
	}

	@objc
	func didTapCheckbox() {
		completionCheckboxTapAction?()
	}


}

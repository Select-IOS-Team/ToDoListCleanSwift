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

	override func layoutSubviews() {
		super.layoutSubviews()
		setupLayout()
	}

	override func sizeThatFits(_ size: CGSize) -> CGSize {
		setupLayout()
		let height = max(Constants.contentViewHeight, titleLabel.frame.height)
		return CGSize(width: contentView.frame.width, height: height)
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
		completionCheckboxImageView.heightAnchor.constraint(
			greaterThanOrEqualToConstant: Constants.contentViewHeight
		).isActive = true
	}

	func setupLayout() {
		completionCheckboxImageView.pin
			.vCenter()
			.start(Constants.contentHorizontalInset)
			.size(Constants.checkboxImageViewSize)

		titleLabel.pin
			.after(of: completionCheckboxImageView, aligned: .center)
			.end()
			.sizeToFit(.width)
			.marginStart(Constants.contentSpace)
			.marginEnd(Constants.contentHorizontalInset)
	}

	func configureUI() {
		selectionStyle = .none
	}

	@objc
	func didTapCheckbox() {
		completionCheckboxTapAction?()
	}
}

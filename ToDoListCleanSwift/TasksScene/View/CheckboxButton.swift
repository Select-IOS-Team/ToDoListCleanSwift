//
//  CheckboxButton.swift
//  TodoList
//
//  Created by Evgeni Meleshin on 11.02.2023.
//

import UIKit

final class CheckboxButton: UIView {

	var isChecked = false

	// Системная картинка
	let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.isHidden = true
		imageView.contentMode = .scaleAspectFit
		imageView.tintColor = .systemGreen
		imageView.image = UIImage(systemName: "checkmark")
		return imageView
	}()

	// Рамка
	let boxView: UIView = {
		let boxView = UIView()
		boxView.layer.borderWidth = 1
		boxView.layer.borderColor = UIColor.label.cgColor
		return boxView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(boxView)
		addSubview(imageView)
		clipsToBounds = true
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		boxView.frame = CGRect(x: 2, y: 2, width: frame.size.width - 4, height: frame.size.width - 4)
		imageView.frame = bounds
	}

	func toggle() {
		self.isChecked = !isChecked
		imageView.isHidden = isChecked
	}
}

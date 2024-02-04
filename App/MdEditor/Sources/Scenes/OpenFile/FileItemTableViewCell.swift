//
//  FileItemTableViewCell.swift
//  MdEditor
//
//  Created by Aksilont on 03.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import UIKit

class FileItemTableViewCell: UITableViewCell {
	static let cellIdentifier = "FileItemCell"

	// MARK: - Private properties
	private lazy var imageViewIcon = makeImageView()
	private lazy var labelText = makeTextLabel()
	private lazy var labelSecondaryText = makeSecondaryTextLabel()
	private lazy var sView = UIView()

	// MARK: - Initialization
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
		layoutSubviews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle
	override func layoutSubviews() {
		super.layoutSubviews()
		layout()
	}

	// MARK: - Public methods
	func configure(with file: OpenFileModel.FileViewModel) {
		var imageName = "doc.text.fill"
		if file.isDir {
			imageName = "folder.fill"
			tintColor = Theme.tintColor
		}
		imageViewIcon.image = UIImage(systemName: imageName)
		labelText.text = file.name
		labelSecondaryText.text = file.description
	}
}

// MARK: - Setup UI
private extension FileItemTableViewCell {
	func makeImageView() -> UIImageView {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}
	
	func makeTextLabel() -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Theme.textColor
		label.lineBreakMode = .byTruncatingMiddle
		label.numberOfLines = 1

		// Accessibility: Font
		label.font = UIFont.preferredFont(forTextStyle: .caption1)
		label.adjustsFontForContentSizeCategory = true
		
		return label
	}

	func makeSecondaryTextLabel() -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Theme.secondaryTextColor
		label.textAlignment = .right
		label.numberOfLines = 2

		// Accessibility: Font
		label.font = UIFont.preferredFont(forTextStyle: .caption2)
		label.adjustsFontForContentSizeCategory = true

		return label
	}

	func setupUI() {
		tintColor = Theme.tintColorCell
		backgroundColor = Theme.backgroundColor

		addSubview(imageViewIcon)
		addSubview(labelText)
		addSubview(labelSecondaryText)
	}

	func layout() {
		let newConstraints = [
			imageViewIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
			imageViewIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.Cell.Padding.normal),
			imageViewIcon.heightAnchor.constraint(equalToConstant: Sizes.Cell.ImageSize.height),
			imageViewIcon.widthAnchor.constraint(equalTo: imageViewIcon.heightAnchor),

			labelText.topAnchor.constraint(equalTo: topAnchor, constant: Sizes.Cell.Padding.normal),
			labelText.leadingAnchor.constraint(equalTo: imageViewIcon.trailingAnchor, constant: Sizes.Cell.Padding.normal),
			labelText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Sizes.Cell.Padding.normal),

			labelSecondaryText.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: Sizes.Cell.Padding.half),
			labelSecondaryText.leadingAnchor.constraint(equalTo: labelText.leadingAnchor),
			labelSecondaryText.trailingAnchor.constraint(equalTo: labelText.trailingAnchor),
			labelSecondaryText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Sizes.Cell.Padding.normal)
		]
		NSLayoutConstraint.activate(newConstraints)
	}
}

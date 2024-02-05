//
//  AboutViewController.swift
//  MdEditor
//
//  Created by Aleksey Efimov on 03.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import UIKit

/// Протокол экрана About.
protocol IAboutViewController: AnyObject {
	
	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewModel: AboutModel.ViewModel)
}

final class AboutViewController: UIViewController {
	
	// MARK: - Dependencies
	
	var interactor: IAboutInteractor?
	
	// MARK: - Private properties
	
	private var viewModel = AboutModel.ViewModel(fileData: "")
	
	private var editable: Bool
	
	private lazy var scrollView: UIScrollView = makeScrollView()
	private lazy var labelAbout: UILabel = makeLabel()
	private lazy var contentView: UIView = makeContentView()

	private var constraints = [NSLayoutConstraint]()
	
	// MARK: - Initialization
	
	init(editable: Bool) {
		self.editable = editable
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		interactor?.fetchData()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		layout()
	}
}

// MARK: - UI setup

private extension AboutViewController {
	
	func setupUI() {
		view.backgroundColor = Theme.backgroundColor
		title = L10n.About.title
		navigationItem.setHidesBackButton(true, animated: true)
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	func makeLabel() -> UILabel {
		let label = UILabel()
		label.text = viewModel.fileData
		label.numberOfLines = 0
		label.font = UIFont.systemFont(ofSize: Sizes.FontSizes.editorText)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
	
	func makeScrollView() -> UIScrollView {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		return scrollView
	}
	
	func makeContentView() -> UIView {
		let contentView = UIView()
		contentView.translatesAutoresizingMaskIntoConstraints = false
		return contentView
	}
}

// MARK: - Layout UI

private extension AboutViewController {
	
	func layout() {
		view.addSubview(scrollView)
		scrollView.addSubview(contentView)
		contentView.addSubview(labelAbout)
		
		NSLayoutConstraint.deactivate(constraints)
		
		let newConstraints = [
			scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			
			contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
			contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
			contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
			
			labelAbout.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Sizes.Padding.normal),
			labelAbout.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Sizes.Padding.normal),
			labelAbout.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Sizes.Padding.normal),
			labelAbout.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Sizes.Padding.normal)
		]
		
		NSLayoutConstraint.activate(newConstraints)
		
		constraints = newConstraints
	}
}

// MARK: - IMainViewController

extension AboutViewController: IAboutViewController {
	func render(viewModel: AboutModel.ViewModel) {
		self.viewModel = viewModel
	}
}

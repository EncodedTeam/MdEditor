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
	
	private var viewModel = AboutModel.ViewModel(fileData: "Text coming soon")
	
	private lazy var textViewFileAbout: UITextView = makeTextView()
	private var constraints = [NSLayoutConstraint]()
	
	// MARK: - Initialization
	
	init() {
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
		
		view.addSubview(textViewFileAbout)
	}
	
	func makeTextView() -> UITextView {
		let textView = UITextView(frame: .zero, textContainer: nil)
		
		textView.backgroundColor = .gray
		textView.contentInset = UIEdgeInsets(
			top: Sizes.Padding.normal,
			left: Sizes.Padding.normal,
			bottom: Sizes.Padding.normal,
			right: Sizes.Padding.normal
		)
		textView.backgroundColor = Theme.backgroundColor
		textView.text = viewModel.fileData
		textView.font = UIFont.systemFont(ofSize: Sizes.FontSizes.editorText)
		textView.isScrollEnabled = true
		textView.keyboardDismissMode = .onDrag
		
		return textView
	}
}

// MARK: - Layout UI

private extension AboutViewController {
	
	func layout() {
		NSLayoutConstraint.deactivate(constraints)
		
		textViewFileAbout.translatesAutoresizingMaskIntoConstraints = false
		
		let safeArea = view.safeAreaLayoutGuide
		let newConstraints = [
			textViewFileAbout.topAnchor.constraint(equalTo: safeArea.topAnchor),
			textViewFileAbout.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
			textViewFileAbout.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
			textViewFileAbout.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
		]
		
		NSLayoutConstraint.activate(newConstraints)
		
		constraints = newConstraints
	}
}

// MARK: - IMainViewController

extension AboutViewController: IAboutViewController {
	func render(viewModel: AboutModel.ViewModel) {
//		self.viewModel = viewModel
	}
}

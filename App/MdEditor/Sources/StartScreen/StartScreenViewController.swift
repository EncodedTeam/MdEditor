//
//  StartScreenViewController.swift
//  MdEditor
//
//  Created by Константин Натаров on 01.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import UIKit

protocol IStartScreenViewController: AnyObject {
	func render(with viewModel: StartScreenModel.ViewModel)
}

final class StartScreenViewController: UIViewController {
	// MARK: - Public properties

	// MARK: - Dependencies

	var interactor: IStartScreenInteractor?

	// MARK: - Private properties
	private lazy var collectionView: UICollectionView = makeCollectionView()
	private var constraints = [NSLayoutConstraint]()
	private var viewModel = StartScreenModel.ViewModel(documents: [])

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
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layout()
	}

	// MARK: - Public methods

	// MARK: - Private methods

}

// MARK: - IStartScreenViewController

extension StartScreenViewController: IStartScreenViewController {
	func render(with viewModel: StartScreenModel.ViewModel) {
		self.viewModel = viewModel
	}
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension StartScreenViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.documents.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: RecentDocumentCell.reuseIdentifier,
			for: indexPath
		) as? RecentDocumentCell
		
		if let imageData = viewModel.documents[indexPath.item].preview {
			cell?.imageView.image = UIImage(data: imageData.data)
		} else {
			cell?.imageView.image = nil
		}

		cell?.label.text = viewModel.documents[indexPath.item].fileName

		return cell ?? UICollectionViewCell()
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		let width = collectionView.frame.width
		let height = collectionView.frame.height

		return CGSize(width: width, height: height)
	}
}

// MARK: - SetupUI

private extension StartScreenViewController {
	func setupUI() {
		title = L10n.StartScreen.title
		navigationItem.setHidesBackButton(true, animated: true)
		navigationController?.navigationBar.prefersLargeTitles = true

		interactor?.fetchData()
		
		collectionView.dataSource = self
		collectionView.delegate = self
		view.addSubview(collectionView)
	}

	func makeCollectionView() -> UICollectionView {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal

		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(RecentDocumentCell.self, forCellWithReuseIdentifier: RecentDocumentCell.reuseIdentifier)
		collectionView.isPagingEnabled = true
		collectionView.showsHorizontalScrollIndicator = true
		collectionView.backgroundColor = .clear

		collectionView.translatesAutoresizingMaskIntoConstraints = false

		return collectionView
	}
}

// MARK: - Layout

private extension StartScreenViewController {

	func layout() {
		NSLayoutConstraint.deactivate(constraints)

		let newConstraints = [
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Sizes.Padding.normal),
			collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
		]

		NSLayoutConstraint.activate(newConstraints)

		constraints = newConstraints
	}
}

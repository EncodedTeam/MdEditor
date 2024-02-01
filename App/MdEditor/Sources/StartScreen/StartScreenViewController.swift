//
//  StartScreenViewController.swift
//  MdEditor
//
//  Created by Константин Натаров on 01.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import UIKit

protocol IStartScreenViewController: AnyObject {

}

final class StartScreenViewController: UIViewController {
	// MARK: - Public properties

	// MARK: - Dependencies

	var interactor: IStartScreenInteractor?

	// MARK: - Private properties



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
		title = "MDEditor"
		navigationItem.setHidesBackButton(true, animated: true)
		navigationController?.navigationBar.prefersLargeTitles = true
		view.backgroundColor = .yellow
	}

	// MARK: - Public methods

	// MARK: - Private methods

}

// MARK: - IStartScreenViewController

extension StartScreenViewController: IStartScreenViewController {}

//
//  OpenFileCoordinator.swift
//  MdEditor
//
//  Created by Aksilont on 03.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import UIKit

final class OpenFileCoordinator: BaseCoordinator {
	// MARK: - Dependencies
	private let navigationController: UINavigationController

	// MARK: - Initialization
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - BaseCoordinator methods
	override func start() {
		showOpenFilesScene()
	}
}

// MARK: - Private methods
private extension OpenFileCoordinator {
	private func showOpenFilesScene() {
		let assembler = OpenFileAssembler()
		let viewController = assembler.assembly()
		navigationController.pushViewController(viewController, animated: true)
	}
}

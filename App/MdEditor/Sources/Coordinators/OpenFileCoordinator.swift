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

	private let url: URL

	var finishFlow: (() -> Void)?
	var enterDirectoryFlow: ((URL) -> Void)?

	// MARK: - Initialization
	init(navigationController: UINavigationController, url: URL) {
		self.navigationController = navigationController
		self.url = url
	}

	// MARK: - BaseCoordinator methods
	override func start() {
		showOpenFilesScene(url: url)
	}
}

// MARK: - Private methods
private extension OpenFileCoordinator {
	private func showOpenFilesScene(url: URL) {
		let assembler = OpenFileAssembler()
		let viewController = assembler.assembly(url: url) { [weak self] url in
			self?.enterDirectoryFlow?(url)
		}
		navigationController.pushViewController(viewController, animated: true)
	}
}

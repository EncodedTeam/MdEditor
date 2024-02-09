//
//  AboutScreenCoordinator.swift
//  MdEditor
//
//  Created by Aleksey Efimov on 09.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import UIKit

final class AboutScreenCoordinator: ICoordinator {
	
	// MARK: - Dependencies
	
	private let navigationController: UINavigationController
	private let fileStorage: IFileStorage
	
	// MARK: - Private properties
	
	private let url: URL
	
	// MARK: - Initialization
	
	init(navigationController: UINavigationController, fileStorage: IFileStorage, url: URL) {
		self.navigationController = navigationController
		self.fileStorage = fileStorage
		self.url = url
	}
	
	// MARK: - Internal methods
	
	func start() {
		showAboutScreenScene()
	}
	
	// MARK: - Private methods
	
	private func showAboutScreenScene() {
		let assembler = AboutScreenAssembler()
		let viewController = assembler.assembly(fileStorage: fileStorage, url: url)
		navigationController.pushViewController(viewController, animated: true)
	}
}

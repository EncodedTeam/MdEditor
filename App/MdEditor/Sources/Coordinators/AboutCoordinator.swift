//
//  AboutCoordinator.swift
//  MdEditor
//
//  Created by Aleksey Efimov on 03.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import UIKit

final class AboutCoordinator: ICoordinator {
	
	// MARK: - Dependencies
	
	private let navigationController: UINavigationController
	private let fileStorage: IFileStorage
	private let url: URL
	private let editable: Bool
	
	// MARK: - Initialization
	
	init(navigationController: UINavigationController, fileStorage: IFileStorage, url: URL, editable: Bool) {
		self.navigationController = navigationController
		self.fileStorage = fileStorage
		self.url = url
		self.editable = editable
	}
	
	// MARK: - Internal methods
	
	func start() {
		showAboutScene()
	}
	
	// MARK: - Private methods
	
	private func showAboutScene() {
		let assembler = AboutAssembler()
		let viewController = assembler.assembly(fileStorage: fileStorage, url: url, editable: editable)
		navigationController.pushViewController(viewController, animated: true)
	}
}

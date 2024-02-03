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
	
	// MARK: - Initialization
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	// MARK: - Internal methods
	
	func start() {
		showAboutScene()
	}
	
	// MARK: - Private methods
	
	private func showAboutScene() {
		let assembler = AboutAssembler()
		let viewController = assembler.assembly()
		navigationController.pushViewController(viewController, animated: true)
	}
}

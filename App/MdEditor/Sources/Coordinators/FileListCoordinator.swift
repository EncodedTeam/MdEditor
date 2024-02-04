//
//  FileListCoordinator.swift
//  MdEditor
//
//  Created by Aksilont on 03.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import UIKit

final class FileListCoordinator: BaseCoordinator {
	// MARK: - Dependencies
	private let navigationController: UINavigationController

	private let urls: [URL]
	private let firstShow: Bool

	var selectFile: ((URL) -> Void)?

	// MARK: - Initialization
	init(navigationController: UINavigationController, urls: [URL], firstShow: Bool) {
		self.navigationController = navigationController
		self.urls = urls
		self.firstShow = firstShow
	}

	// MARK: - BaseCoordinator methods
	override func start() {
		showFileListScene(urls: urls)
	}
}

// MARK: - Private methods
private extension FileListCoordinator {
	func showFileListScene(urls: [URL]) {
		let assembler = FileListAssembler()
		let viewController = assembler.assembly(urls: urls, firstShow: firstShow) { [weak self] url in
			self?.selectFile?(url)
		}
		navigationController.pushViewController(viewController, animated: true)
	}
}

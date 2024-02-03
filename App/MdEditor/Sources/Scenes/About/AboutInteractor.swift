//
//  AboutInteractor.swift
//  MdEditor
//
//  Created by Aleksey Efimov on 03.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

protocol IAboutInteractor: AnyObject {
	/// Событие на предоставление данных из файла about.
	func fetchData()
}

final class AboutInteractor: IAboutInteractor {
	
	// MARK: - Dependencies
	
	private var presenter: IAboutPresenter?
	
	// MARK: - Initialization
	
	init(presenter: IAboutPresenter) {
		self.presenter = presenter
	}
	
	// MARK: - Public methods
	
	func fetchData() {
	}
}

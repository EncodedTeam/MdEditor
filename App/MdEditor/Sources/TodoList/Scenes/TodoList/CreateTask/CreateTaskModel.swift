//
//  CreateTaskModel.swift
//  TodoList
//
//  Created by Kirill Leonov on 05.12.2023.
//

import Foundation

enum CreateTaskModel {

	enum Request {
		case regular(String)
		case important(ImportantTask)

		struct ImportantTask {
			let title: String
			let priority: Int
		}
	}
}

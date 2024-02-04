//
//  OpenFileModel.swift
//  MdEditor
//
//  Created by Aksilont on 31.01.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

enum OpenFileModel {
	struct FileViewModel {
		let url: URL
		let name: String
		let isDir: Bool
		let description: String
	}

	struct Request {
		let title: String
		let url: URL
	}

	struct Response {
		let data: [FileViewModel]
	}
	
	struct ViewModel { 
		let data: [FileViewModel]
	}
}

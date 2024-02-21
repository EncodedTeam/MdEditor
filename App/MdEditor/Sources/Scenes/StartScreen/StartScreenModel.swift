//
//  StartScreenModel.swift
//  MdEditor
//
//  Created by Константин Натаров on 01.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

/// StartScreenModel is namespace for splt viewModels
enum StartScreenModel {
	enum MenuIdentifier {
		case openFile
		case newFile
		case showAbout
	}

	enum Request {
		case openFileList
		case creaeteNewFile
		case showAbout
		case recentFileSelected(indexPath: IndexPath)
	}

	struct Response {
		let docs: [Document]
	}

	struct ViewModel {
		let documents: [Document]
	}
	struct Document {
		let fileName: String
		let content: String
	}
}

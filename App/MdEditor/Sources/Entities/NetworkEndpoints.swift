//
//  NetworkEndpoints.swift
//  MdEditor
//
//  Created by Aksilont on 24.03.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

enum NetworkEndpoints {
	static let baseURL = URL(string: "https://practice.swiftbook.org")! // swiftlint:disable:this force_unwrapping
	
	case login
	case getAllFiles
	case getFile(id: String)
	case download(id: String)
	case upload
	case delete(id: String)
}

extension NetworkEndpoints: CustomStringConvertible {
	var description: String {
		switch self {
		case .login:
			return "/api/auth/login"
		case .getAllFiles:
			return "/api/files"
		case .getFile(let id):
			return "/api/files/\(id)"
		case .download(let id):
			return "/api/files/download/\(id)"
		case .upload:
			return "/api/files/upload"
		case .delete(let id):
			return "/api/files/\(id)"
		}
	}
}

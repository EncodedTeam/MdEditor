//
//  FileNetworkEntity.swift
//  MdEditor
//
//  Created by Aksilont on 25.03.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

struct FileNetworkEntity: Codable {
	let id: String
	let hash: String
	let originalName: String
	let contentType: String
	let size: Int
	let createdAt: String
	let updatedAt: String
	let version: Int
	let url: String

	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case hash
		case originalName
		case contentType
		case size
		case createdAt
		case updatedAt
		case version = "__v"
		case url
	}
}

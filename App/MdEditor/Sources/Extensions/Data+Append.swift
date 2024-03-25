//
//  Data+Append.swift
//  MdEditor
//
//  Created by Aksilont on 25.03.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

extension Data {
	mutating func append(_ string: String, encoding: String.Encoding = .utf8) {
		guard let data = string.data(using: encoding) else { return }
		append(data)
	}
}

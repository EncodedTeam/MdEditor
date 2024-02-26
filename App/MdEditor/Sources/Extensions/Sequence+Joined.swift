//
//  Sequence+Joined.swift
//  MdEditor
//
//  Created by Aleksey Efimov on 26.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation

extension Sequence where Iterator.Element == NSMutableAttributedString {
	func joined() -> NSMutableAttributedString {
		reduce(into: NSMutableAttributedString()) { $0.append($1) }
	}
}

//
//  ProtocolIVisiter.swift
//  MdEditor
//
//  Created by Aleksey Efimov on 21.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import Foundation
import MarkdownPackage

extension Document {
	func accept<T: IVisitor>(_ visitor: T) -> [T.Result] {
		return visitor.visit(self)
	}
}

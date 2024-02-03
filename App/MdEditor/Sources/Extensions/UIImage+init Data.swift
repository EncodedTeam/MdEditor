//
//  UIImage+init Data.swift
//  MdEditor
//
//  Created by Константин Натаров on 01.02.2024.
//  Copyright © 2024 EncodedTeam. All rights reserved.
//

import UIKit

extension UIImage {
	convenience init?(data: Data?) {
		guard let data = data else {
			return nil
		}
		self.init(data: data)
	}
}

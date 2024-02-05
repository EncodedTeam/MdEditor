//
//  Sizes.swift
//  MdEditor
//
//  Created by Kirill Leonov on 14.11.2023.
//

import Foundation

// swiftlint:disable type_name
enum Sizes {

	static let cornerRadius: CGFloat = 6
	static let borderWidth: CGFloat = 1
	static let topInset: CGFloat = 180.0

	enum FontSizes {
		static let editorText: CGFloat = 18
	}
	
	enum Padding {
		static let half: CGFloat = 8
		static let normal: CGFloat = 16
		static let double: CGFloat = 32
	}

	enum L {
		static let width: CGFloat = 200
		static let height: CGFloat = 50
		static let widthMultiplier: CGFloat = 0.9
	}

	enum M {
		static let width: CGFloat = 100
		static let height: CGFloat = 40
	}

	enum S {
		static let width: CGFloat = 80
		static let height: CGFloat = 30
	}

	enum Cell {
		enum Padding {
			static let half: CGFloat = 4
			static let normal: CGFloat = 8
			static let double: CGFloat = 16
		}
		enum Image {
			static let width: CGFloat = 30
			static let height: CGFloat = 30
		}
		enum Text {
			static let ratioWidth: CGFloat = 0.5
			static let numberOfLines = 3
		}
		enum SecondaryText {
			static let numberOfLines = 3
		}
	}
}
// swiftlint:enable type_name

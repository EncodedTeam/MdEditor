//
//  Colors.swift
//  MdEditor
//
//  Created by Aksilont on 12.01.2024.
//

import UIKit

enum Colors {
	static let red = UIColor.color(
		light: Asset.WarmAndCold.Red.punch.color,
		dark: Asset.WarmAndCold.Red.bitterSweet.color
	)
	static let orange = UIColor.color(
		light: Asset.WarmAndCold.Orange.warm.color,
		dark: Asset.WarmAndCold.Orange.mustard.color
	)
	static let green = UIColor.color(
		light: Asset.WarmAndCold.Green.arlekin.color,
		dark: Asset.WarmAndCold.Green.paleGreen.color
	)
	static let blue = UIColor.color(
		light: Asset.WarmAndCold.Blue.oceanBreeze.color,
		dark: Asset.WarmAndCold.Blue.turquoise.color
	)
	static let purple = UIColor.color(
		light: Asset.WarmAndCold.Purple.purple.color,
		dark: Asset.WarmAndCold.Purple.orchid.color
	)
	static let white = UIColor.color(
		light: UIColor(hex: 0xFFFFFF),
		dark: UIColor(hex: 0x000000)
	)
	static let black = UIColor.color(
		light: UIColor(hex: 0x000000),
		dark: UIColor(hex: 0xFFFFFF)
	)
	static let dark = UIColor.color(
		light: Asset.WarmAndCold.Blue.fadedBlue.color,
		dark: Asset.WarmAndCold.Gray.iron.color
	)
	static let light = UIColor.color(
		light: Asset.WarmAndCold.Gray.iron.color,
		dark: Asset.WarmAndCold.Blue.fadedBlue.color
	)
}

enum Theme {
	static let mainColor = Colors.orange
	static let accentColor = Colors.red
	static let backgroundColor = Colors.light

	static let white = Colors.white
	static let black = Colors.black
}

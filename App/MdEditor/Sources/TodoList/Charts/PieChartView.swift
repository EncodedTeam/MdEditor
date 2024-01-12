//
//  PieChartView.swift
//  TodoList
//

import UIKit

struct Segment {
	var color: UIColor
	var value: CGFloat
}

final class PieChartView: UIView {
	
	// MARK: - Internal methods

	var segments = [Segment]() {
		didSet {
			setNeedsDisplay()
		}
	}
	
	// MARK: - Init methods

	override init(frame: CGRect) {
		super.init(frame: frame)
		translatesAutoresizingMaskIntoConstraints = false
		isOpaque = false
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	// MARK: - Override methods

	override func draw(_ rect: CGRect) {
		guard let ctx = UIGraphicsGetCurrentContext() else { return }

		let radius = min(bounds.width, bounds.height) * 0.5
		let viewCenter = CGPoint(x: bounds.midX, y: bounds.midY)
		let valueCount = segments.reduce(0, { $0 + $1.value })

		var startAngle: CGFloat = -.pi * 0.5

		for segment in segments {
			ctx.setFillColor(segment.color.cgColor)

			let endAngle = startAngle + 2 * .pi * (segment.value / valueCount)

			ctx.move(to: viewCenter)
			ctx.addArc(
				center: viewCenter,
				radius: radius,
				startAngle: startAngle,
				endAngle: endAngle,
				clockwise: false
			)

			ctx.fillPath()
			startAngle = endAngle
		}
	}
}

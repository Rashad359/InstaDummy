//
//  GradientBorderView.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/29/25.
//

import UIKit

final class GradientBorderView: UIView {
    private let gradientLayer = CAGradientLayer()
    private let borderShape = CAShapeLayer()

    /// Public config
    var gradientColors: [UIColor] = [.systemRed, .systemGreen] {
        didSet { gradientLayer.colors = gradientColors.map { $0.cgColor } }
    }
    var lineWidth: CGFloat = 2 {
        didSet { borderShape.lineWidth = lineWidth; setNeedsLayout() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        // configure gradient
        gradientLayer.name = "gradientBorder"
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.colors = gradientColors.map { $0.cgColor }

        // configure shape (used as mask so only stroke shows)
        borderShape.fillColor = UIColor.clear.cgColor
        borderShape.lineWidth = lineWidth
        borderShape.strokeColor = UIColor.black.cgColor // color doesn't matter (mask)

        // Add the gradient layer
        layer.addSublayer(gradientLayer)

        // Use the shape as a mask of the gradient
        gradientLayer.mask = borderShape

        // Important: gradient is a sibling of content — don't clip subviews (we want content inside)
        // layer.masksToBounds = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // ensure gradient fills view bounds
        gradientLayer.frame = bounds

        // Make the border path inset by half the line width so stroke sits inside view bounds
        let inset = lineWidth / 2.0
        let cornerR = layer.cornerRadius
        let rect = bounds.insetBy(dx: inset, dy: inset)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerR).cgPath

        borderShape.path = path
        borderShape.lineWidth = lineWidth
    }
}


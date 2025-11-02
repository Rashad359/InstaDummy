//
//  UIView+Ext.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/29/25.
//

import UIKit

extension UIView {
    func setGradientBorder(colors: [UIColor], lineWidth: CGFloat) {
            // Remove any previous gradient border
            layer.sublayers?.removeAll(where: { $0.name == "gradientBorder" })
            
            // Create the gradient layer
            let gradient = CAGradientLayer()
            gradient.name = "gradientBorder"
            gradient.frame = bounds
            gradient.colors = colors.map { $0.cgColor }
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
            
            // Create a shape layer that defines the border path
            let shape = CAShapeLayer()
            shape.lineWidth = lineWidth
            shape.path = UIBezierPath(roundedRect: bounds.insetBy(dx: lineWidth / 2, dy: lineWidth / 2),
                                      cornerRadius: layer.cornerRadius).cgPath
            shape.fillColor = UIColor.clear.cgColor
            shape.strokeColor = UIColor.black.cgColor
            
            // Use the shape as a mask
            gradient.mask = shape
            
            // Add the gradient to the view
            layer.addSublayer(gradient)
        }
}

//
//  UIView + Gradient.swift
//  FinBook
//
//  Created by Владимир Рубис on 16.12.2021.
//

import UIKit

extension UIView {
    func addVerticalGradientLayer(topColor: UIColor, bottomColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        layer.insertSublayer(gradient, at: 0)
    }
    
    func addHorizontalGradientLayer(leftColor: UIColor, rightColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [leftColor.cgColor, rightColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        layer.insertSublayer(gradient, at: 0)
    }
    
    func customizeView(model: Int) {
        self.backgroundColor =
        ColorManager.shared.hexStringToUIColor(hex: Pallete.getColorDecor().0)
        self.layer.borderColor = ColorManager.shared.hexStringToUIColor(hex: Pallete.getColorDecor().1).cgColor
        self.layer.borderWidth = 3
    }
}


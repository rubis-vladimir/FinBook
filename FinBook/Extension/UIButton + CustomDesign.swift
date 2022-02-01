//
//  UIButton + CustomDesign.swift
//  FinBook
//
//  Created by Владимир Рубис on 13.01.2022.
//

import UIKit

extension UIButton {
    
    func customizeButton(cradius: CGFloat) {
        layer.cornerRadius = cradius
        layer.borderColor = ColorManager.shared.hexStringToUIColor(hex: Pallete.getColorDecor().1).cgColor
        layer.borderWidth = 3
        backgroundColor =  ColorManager.shared.hexStringToUIColor(hex: Pallete.getColorDecor().0)
        titleLabel?.font = UIFont(name: "Avenir Heavy", size: 20)
    }
}

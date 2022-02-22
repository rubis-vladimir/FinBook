//
//  UIView + Customization.swift
//  FinBook
//
//  Created by Владимир Рубис on 16.12.2021.
//

import UIKit

extension UIView {
    
    func customizeView(model: Int) {
        self.backgroundColor =
        UIColor.hex(PaletteModel.getColorDecor().0)
        self.layer.borderColor = UIColor.hex(PaletteModel.getColorDecor().1).cgColor
        self.layer.borderWidth = 3
    }
}


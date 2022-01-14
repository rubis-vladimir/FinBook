//
//  UILabel + ColorTheme.swift
//  FinBook
//
//  Created by Владимир Рубис on 13.01.2022.
//

import UIKit

extension UILabel {
    
    func changeColor() {
        let model = ColorManager.shared.retrieveThemeData()
        self.textColor = ColorManager.shared.hexStringToUIColor(hex: Pallete.getPallete(model: model).secondaryColor)
    }
}

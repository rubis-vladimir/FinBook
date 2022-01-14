//
//  UIButton + CustomDesign.swift
//  FinBook
//
//  Created by Владимир Рубис on 13.01.2022.
//

import UIKit

extension UIButton {
    
    func customizeButton(model: Int, cradius: CGFloat, bgc: Bool) {
        self.layer.cornerRadius = cradius
        self.layer.borderColor = ColorManager.shared.hexStringToUIColor(hex: Pallete.getPallete(model: model).secondaryColor).cgColor
        self.layer.borderWidth = 3
        
        if bgc {
            self.backgroundColor =  ColorManager.shared.hexStringToUIColor(hex: Pallete.getPallete(model: model).primaryColor)
        }
        self.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 20)
    }
}

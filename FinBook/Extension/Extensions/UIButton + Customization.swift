//
//  UIButton + CustomDesign.swift
//  FinBook
//
//  Created by Владимир Рубис on 13.01.2022.
//

import UIKit

// MARK: Расширение для UIButton
extension UIButton {
    
    /// Кастомизирует кнопку
    func customizeButton(cradius: CGFloat) {
        layer.cornerRadius = cradius
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 2
        backgroundColor =  UIColor.systemMint
        layer.masksToBounds = true
        titleLabel?.font = UIFont(name: "Avenir Heavy", size: 20)
    }
}

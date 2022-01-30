//
//  CALayer + Customization.swift
//  FinBook
//
//  Created by Владимир Рубис on 30.01.2022.
//

import QuartzCore
import UIKit

extension CALayer {
    func customizeView() {
        cornerRadius = 10
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.6
        shadowOffset = CGSize(width: 1.2, height: 1.2)
        shadowRadius = 1
    }
}
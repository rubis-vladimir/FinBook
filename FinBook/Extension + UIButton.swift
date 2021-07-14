//
//  Extension + UIButton.swift
//  FinBook
//
//  Created by Владимир Рубис on 14.07.2021.
//

import UIKit

class improveButton: UIButton {

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let pointIsInside = super.point(inside: point, with: event)
        if pointIsInside == false {
            for subview in subviews {
                let pointInSubview = subview.convert(point, from: self)
                if subview.point(inside: pointInSubview, with: event) {
                    return true
                }
            }
        }
        return pointIsInside
    }

}

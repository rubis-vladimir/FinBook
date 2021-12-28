//
//  CustomTabBar.swift
//  FinBook
//
//  Created by Владимир Рубис on 12.07.2021.
//

import UIKit

class CustomTabBar: UITabBar {
    
    // MARK: Override draw and button touch
    
    override func draw(_ rect: CGRect) { }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let buttonRadius: CGFloat = self.bounds.height * 0.5
        let pointIsInside = super.point(inside: point, with: event)
        if pointIsInside == true {
            for _ in subviews {
                if abs(self.center.x - point.x) < buttonRadius && abs(point.y) < buttonRadius {
                    return false
                }
            }
        }
        return pointIsInside
    }
}

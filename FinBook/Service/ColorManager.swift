//
//  ColorManager.swift
//  FinBook
//
//  Created by Владимир Рубис on 02.12.2021.
//

import UIKit

class ColorManager {
    
    static let shared = ColorManager()
    
    func createPalitreColors(hexColors: [String]) -> [UIColor] {
        var palitreColors: [UIColor] = []
        for i in hexColors {
            let color = hexStringToUIColor(hex: i)
            palitreColors.append(color)
        }
        return palitreColors
    }
    
    private func hexStringToUIColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

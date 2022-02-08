//
//  ColorManager.swift
//  FinBook
//
//  Created by Владимир Рубис on 02.12.2021.
//

import UIKit

class ColorManager {
    
    static let shared = ColorManager()
    
    // MARK: - Setting theme palette colors
        
    func setThemeColors(mainElement: UIView, secondaryElement: UINavigationBar?) {
            let model = UserDefaultManager.shared.retrieveThemeData()
            let themeValue = Pallete.getPallete(model: model)
            let color = hexStringToUIColor(hex: themeValue.bgColor)
            if (secondaryElement != nil) {
                secondaryElement?.barTintColor = hexStringToUIColor(hex: themeValue.bgColor)
                secondaryElement?.tintColor = hexStringToUIColor(hex: themeValue.textColor)
                let textAttributes = [NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: themeValue.textColor)]
                secondaryElement?.titleTextAttributes = textAttributes
            }
            
            mainElement.backgroundColor = color
            
            
        }
    
    // MARK: - Creating array colors
    
    func createPalitreColors() -> [UIColor] {
        let model = UserDefaultManager.shared.retrieveThemeData()
        let hexColors = Pallete.getPallete(model: model).chartColors
        var paletteColors: [UIColor] = []
        
        for i in hexColors {
            let color = hexStringToUIColor(hex: i)
            paletteColors.append(color)
        }
        return paletteColors
    }
    
    // MARK: - Converting hex color to UIColor
    
    func hexStringToUIColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
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

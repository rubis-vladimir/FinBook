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
            mainElement.backgroundColor = color
            
            if (secondaryElement != nil) {
                secondaryElement?.barTintColor = color
////                secondaryElement?.setBackgroundImage(UIImage(named: "rubis"), for: .default)
//                secondaryElement?.tintColor = .white
//                let textAttributes = [NSAttributedString.Key.foregroundColor:color]
//                secondaryElement?.titleTextAttributes = textAttributes
            }
//            if (secondaryElement != nil) {
//            secondaryElement?.barTintColor = color
//            mainElement.tintColor = color
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

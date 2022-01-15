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
            let themeValue = retrieveThemeData()
            let model = Pallete.getPallete(model: themeValue)
            let color = hexStringToUIColor(hex: model.bgColor)
            mainElement.backgroundColor = color
            
            if (secondaryElement != nil) {
                secondaryElement?.barTintColor = color
            }
        }
    
    // MARK: - Creating array colors
    
    func createPalitreColors() -> [UIColor] {
        let model = ColorManager.shared.retrieveThemeData()
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
    
    // MARK: - Saving theme data to User Defaults
        
        func saveThemeData(value: Int) {
            let defaults = UserDefaults.standard
            defaults.set(value, forKey: "theme")
        }
        
    // MARK: - Retrieving theme data from User Defaults
        
        func retrieveThemeData() -> Int{
            let defaults = UserDefaults.standard
            guard let savedValue = defaults.value(forKey: "theme") else { return 0 }
            return savedValue as! Int
        }
}

//
//  UIColor +.swift
//  FinBook
//
//  Created by Владимир Рубис on 09.02.2022.
//

import UIKit

// MARK: Расширение для UIColor
extension UIColor {
    
    /// Преобразует цвет из `String` в `UIColor`
    ///  - Parameters:
    ///     - hexString: цвет в формате HEX
    static func hex(_ hexString: String) -> UIColor {
        
        var hexString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") { hexString.remove(at: hexString.startIndex) }
        
        var rgbValue:UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        return .init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    /// Преобразует массив HEX-цветов с типом `String` в массив цветов `UIColor`
    static func convertType(_ palette: [String]) -> [UIColor] {
        var paletteColors: [UIColor] = []
        
        for i in palette {
            let color = UIColor.hex(i)
            paletteColors.append(color)
        }
        return paletteColors
    }
    
    /// Устанавливает цвет 
    ///   - Parameters:
    ///     - light: цвет для светлой темы
    ///     - dark: цвет для темной темы
    ///   - Returns: цвет выбранной темы приложения
    static func color(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor.init { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? dark : light
        }
    }
}

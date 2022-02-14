//
//  UIColor +.swift
//  FinBook
//
//  Created by Владимир Рубис on 09.02.2022.
//

import UIKit

extension UIColor {
    
    static func color(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor.init { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? dark : light
        }
    }
    
    static func isDark() -> Bool {
        let traitCollection = UITraitCollection.current
        return traitCollection.userInterfaceStyle == .dark ? true : false
    }
    
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
    
    static func convertType(_ palette: [String]) -> [UIColor] {
        var paletteColors: [UIColor] = []
        
        for i in palette {
            let color = UIColor.hex(i)
            paletteColors.append(color)
        }
        return paletteColors
    }
    //
    //    static func createPalitreColors() -> [UIColor] {
    //        let model = 0
    //        let hexColors = PaletteModel.getPalette(model: model).chartColors
    //        var paletteColors: [UIColor] = []
    //
    //        for i in hexColors {
    //            let color = UIColor.hex(i)
    //            paletteColors.append(color)
    //        }
    //        return paletteColors
    //    }
    
    //    private func convertType(_ palette: [String]) -> [UIColor] {
    //        var paletteColors: [UIColor] = []
    //
    //        for i in palette {
    //            let color = UIColor.hex(i)
    //            paletteColors.append(color)
    //        }
    //        return paletteColors
    //    }
    
    struct Palette {
        
        static let white = UIColor.color(light: .white, dark: .black)
        static let black = UIColor.color(light: .black, dark: .white)
        
        static let background = UIColor.color(light: .white, dark: .hex("1b1b1d"))
        static let secondaryBackground = UIColor(named: "secondaryBackground") ?? .black
        static let tabbarBG = UIColor.color(light: .hex("E5E5EA"), dark: .hex("2C2C2E"))
        
        static func colorsChart() -> [UIColor] {
            var osTheme: UIUserInterfaceStyle {
                return UIScreen.main.traitCollection.userInterfaceStyle
            }
            
            let colors = osTheme == .dark
            ? PaletteModel.getPalette(model: 0)
            : PaletteModel.getPalette(model: 1)
            
            return UIColor.convertType(colors)
        }
        
        static func cgColor() -> CGColor {
            return UIColor.Palette.tabbarBG.cgColor
            }
        
        
    }
}

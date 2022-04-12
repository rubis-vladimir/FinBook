//
//  Palette.swift
//  FinBook
//
//  Created by Владимир Рубис on 16.12.2021.

import UIKit

struct Palette {
    static let background = UIColor.color(light: .white, dark: .hex("1b1b1d"))
    
    static func getChartPalette() -> [UIColor] {
        var palette: [String]
        
        switch Theme.current {
        case .dark:
            palette = ["66c6cc", "f6cf71", "f89c74", "dcb0f2", "87c55f", "9eb9f3", "fe88b1", "c9db74", "8be0a4"]
        default:
            palette = ["78A5A3", "CE5A57", "E1B16A", "664975", "99705B", "D6606D", "767E8C",  "A09151", "AD9ED3"]
        }
        return UIColor.convertType(palette)
    }
}


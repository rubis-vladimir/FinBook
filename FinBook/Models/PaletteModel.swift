//
//  PaletteModel.swift
//  FinBook
//
//  Created by Владимир Рубис on 16.12.2021.

struct PaletteModel {
    let bgColor: String
    let textColor: String
    let chartColors: [String]
    
    static func getPalette(model: Int) -> [String] {
        var palette: [String]
        switch model {
            
            // MARK: - dark theme
        case 0:
            palette = ["66c6cc", "f6cf71", "f89c74", "dcb0f2", "87c55f", "9eb9f3", "fe88b1", "c9db74", "8be0a4"]
            
            // MARK: - light theme
        default:
            palette = ["78A5A3", "CE5A57", "E1B16A", "664975", "99705B", "D6606D", "767E8C",  "A09151", "AD9ED3"]
        }
        return palette
    }
    
    static func getColorDecor() -> (String, String) {
        // MARK: - color decor for elements
        return ("#889397","656D77")
    }
}

// "767E8C", "CE5A57", "78A5A3", "E1B16A"
// "EB8A44", "F9DC24", "4B7447", "8EBA43"
// "66c6cc", "f6cf71", "f89c74", "dcb0f2", "87c55f", "9eb9f3", "fe88b1", "c9db74", "8be0a4", "b497e7"

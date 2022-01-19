//
//  Palette.swift
//  FinBook
//
//  Created by Владимир Рубис on 16.12.2021.


struct Pallete {
    static func getPallete(model: Int) -> PaletteModel {
        var palette: PaletteModel
        switch model {
            
            // MARK: - dark theme
        case 0:
            palette = PaletteModel(bgColor: "#B5C0C4", chartColors: ["F98866", "FF420E", "80BD9E", "89DA59"])
            
            // MARK: - light theme
        default:
            palette = PaletteModel(bgColor: "#FFFFFF", chartColors: ["767E8C", "CE5A57", "78A5A3", "E1B16A"])
        }
        return palette
    }
    
    static func getColorDecor() -> (String, String) {
        // MARK: - color decor for elements
        return ("#889397","656D77")
    }
}

// "EB8A44", "F9DC24", "4B7447", "8EBA43"

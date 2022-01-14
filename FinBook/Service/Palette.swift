//
//  Palette.swift
//  FinBook
//
//  Created by Владимир Рубис on 16.12.2021.


struct Pallete {
    static func getPallete(model: Int) -> PaletteModel {
        var palette: PaletteModel
        switch model {

// MARK: - gray theme
        case 0:
            palette = PaletteModel(primaryColor: "#FFFFFF", secondaryColor: "#000000", chartColors: ["767E8C", "CE5A57", "78A5A3", "E1B16A"])
            
// MARK: - blue theme
        case 1:
            palette = PaletteModel(primaryColor: "#B0BBBF", secondaryColor: "#FFFFFF", chartColors: ["CE5A57", "78A5A3", "767E8C", "E1B16A"])
            
// MARK: - yellow theme
        default:
            palette = PaletteModel(primaryColor: "#889397", secondaryColor: "#656D76", chartColors: ["767E8C", "CE5A57", "78A5A3", "E1B16A"])
        }
        return palette
    }
}

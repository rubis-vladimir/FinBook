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
            palette = PaletteModel(primaryColor: "#97999B", secondaryColor: "#7D8085", textColor: "#F8F5F1")
            
// MARK: - blue theme
        case 1:
            palette = PaletteModel(primaryColor: "#D8E3E7", secondaryColor: "#126E82", textColor: "#FFFFFF")
            
// MARK: - yellow theme
        default:
            palette = PaletteModel(primaryColor: "#FBEEAC", secondaryColor: "#F4D160", textColor: "#28527A")
        }
        return palette
    }
}

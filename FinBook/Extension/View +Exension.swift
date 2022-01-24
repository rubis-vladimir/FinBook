//
//  View +Exension.swift
//  FinBook
//
//  Created by Владимир Рубис on 24.01.2022.
//

import UIKit

extension UIView {
    
// MARK: - Setting theme palette colors
    
    func setThemeColors(mainElement: UIView, secondaryElement: UINavigationBar?) {
//        let themeValue = Int(retrieveThemeData())
//        let model = ThemeModel.getThemeModel(model: themeValue ?? 0)
        mainElement.backgroundColor = .gray
        if (secondaryElement != nil) {
            secondaryElement?.barTintColor = .purple
            secondaryElement?.tintColor = .white
            let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
            secondaryElement?.titleTextAttributes = textAttributes
        }
        mainElement.tintColor = .white
    }
}

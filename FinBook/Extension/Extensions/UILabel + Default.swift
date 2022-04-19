//
//  UILabel + Default.swift
//  FinBook
//
//  Created by Владимир Рубис on 01.02.2022.
//

import UIKit

// MARK: Рвсширение для UILabel
extension UILabel {
    
    /// Настраивает лейбл
    ///   - Parameters:
    ///     - view: вью
    ///     - title: текст лейбла
    ///     - isCenter: в центре/смещено
    func setupDefaultLabel(view: UIView, title: String, inCenter: Bool) {
        text = title
        textColor = .systemGray
        textAlignment = .center
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(self)
        
        /// Настройка констрейнтов
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        widthAnchor.constraint(equalToConstant: view.bounds.width * 0.7).isActive = true
        
        if inCenter {
        topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        } else {
            topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        }
    }
}

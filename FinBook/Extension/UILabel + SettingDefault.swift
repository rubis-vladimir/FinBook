//
//  UILabel + SettingDefault.swift
//  FinBook
//
//  Created by Владимир Рубис on 01.02.2022.
//

import UIKit

extension UILabel {
    func setupDefaultLabel(view: UIView) {
        font = UIFont(name: "Avenir", size: 20)
        textColor = .systemGray3
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .center
        
        // Setup constraints
        view.addSubview(self)
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        widthAnchor.constraint(equalToConstant: view.bounds.width * 0.7).isActive = true
    }
}

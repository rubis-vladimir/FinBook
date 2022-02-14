//
//  UILabel + SettingDefault.swift
//  FinBook
//
//  Created by Владимир Рубис on 01.02.2022.
//

import UIKit

extension UILabel {
    func setupDefaultLabel(view: UIView, title: String) {
        text = title
        font = UIFont(name: "Avenir", size: 20)
        textColor = .systemGray
        textAlignment = .center
        numberOfLines = 0
        
        view.addSubview(self)
        
        // Setup constraints
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topAnchor.constraint(equalTo: view.centerYAnchor, constant: 10).isActive = true
        widthAnchor.constraint(equalToConstant: view.bounds.width * 0.7).isActive = true
    }
}

//
//  CategoriesView.swift
//  FinBook
//
//  Created by Сперанский Никита on 30.08.2021.
//

import UIKit

final class CategoriesView: UIView {
    
    // MARK: - Properties
    private let iconView = UIImageView()
    private let label = UILabel()
    
    // MARK: - Override func
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Private func - статический метод create, который будет создавать необходимое View
    static func create(icon: UIImage, title: String) -> CategoriesView {
        let categoryView = CategoriesView()
        categoryView.iconView.image = icon
        categoryView.label.text = title
        
        return categoryView
    }
    
    // MARK: - Private func - настройка констрейнтов - расположение элементов на View
    private func setup() {
        addSubview(label)
        addSubview(iconView)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        let iconWidth: CGFloat = 22.0

        NSLayoutConstraint.activate([
            
//            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.0),
            
            iconView.widthAnchor.constraint(equalToConstant: iconWidth),
            iconView.heightAnchor.constraint(equalToConstant: iconWidth),
            
            iconView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 10.0),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])

        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 19)
        label.textAlignment = .left

        iconView.contentMode = .scaleAspectFit
    }
}

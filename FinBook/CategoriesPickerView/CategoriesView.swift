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
        addSubview(iconView)
        addSubview(label)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        let iconWidth: CGFloat = 20.0

        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: iconWidth),
            iconView.heightAnchor.constraint(equalToConstant: iconWidth),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.0),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),

            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 10.0)
        ])

        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left

        iconView.contentMode = .scaleAspectFit
    }
}

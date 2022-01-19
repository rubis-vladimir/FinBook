//
//  Test2CollectionViewCell.swift
//  FinBook
//
//  Created by Владимир Рубис on 19.01.2022.
//

import UIKit

class Test2CollectionViewCell: UICollectionViewCell {
    
    static var reuseId: String = "Test2Cell"
    
    let photo = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 1, alpha: 1)
        setupElements()
        setupConstraints()
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    
    func setupElements() {
        photo.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(with developer: Developer) {
        photo.image = UIImage(named: developer.photo)
    }
    
    func configure2(with developer: Developer) {
        photo.image = UIImage(named: developer.photo)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Constraints
extension Test2CollectionViewCell {
    func setupConstraints() {
        addSubview(photo)
        
        // oponentImageView constraints
        photo.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        photo.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        photo.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        photo.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
    }
}

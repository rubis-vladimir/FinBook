//
//  Test2CollectionViewCell.swift
//  FinBook
//
//  Created by Владимир Рубис on 19.01.2022.
//

import UIKit

class ContactPhotoCell: UICollectionViewCell {
    
    static var reuseId: String = "contactPhotoCell"
    
    let photoView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        setupConstraints()
    }
    
    func setupElements() {
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.layer.cornerRadius = frame.width / 2
        photoView.clipsToBounds = true
    }
    
    func configure(with developer: Developer) {
        photoView.image = UIImage(named: developer.photo)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Constraints
extension ContactPhotoCell {
    func setupConstraints() {
        addSubview(photoView)
        
        // photoView constraints
        photoView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        photoView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        photoView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        photoView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
}

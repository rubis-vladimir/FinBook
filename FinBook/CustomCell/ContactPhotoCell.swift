//
//  ContactPhotoCell.swift
//  FinBook
//
//  Created by Владимир Рубис on 19.01.2022.
//

import UIKit

class ContactPhotoCell: UICollectionViewCell {
    
    static var reuseId: String = "contactPhotoCell"
    
    let photoView = UIImageView()
    
    let nameLabel = BorderedLabel()
    let surnameLabel = BorderedLabel()
    let stackFullname = UIStackView()
    
    let font = UIFont(name: "Avenir", size: 18)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        setupConstraints()
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.backgroundColor = .systemGray3
    }
    
    func setupElements() {
        // setup photoView
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.layer.cornerRadius = frame.width / 2 - 10
        photoView.clipsToBounds = true
        
        // setup labels
        nameLabel.font = font
        nameLabel.textAlignment = .center
        surnameLabel.font = font
        surnameLabel.textAlignment = .center
        
        // setup stacks
        stackFullname.translatesAutoresizingMaskIntoConstraints = false
        stackFullname.axis = .vertical
        stackFullname.distribution = .fillEqually
        stackFullname.layer.cornerRadius = 10
        stackFullname.backgroundColor = .systemGray4
    }
    
    func configure(with developer: Developer) {
        nameLabel.text = developer.name
        surnameLabel.text = developer.surname
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
        addSubview(stackFullname)
        
        // photoView constraints
        photoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        photoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        photoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor).isActive = true
        
        // stackFullname constraints
        stackFullname.addArrangedSubview(surnameLabel)
        stackFullname.addArrangedSubview(nameLabel)
        stackFullname.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 10).isActive = true
        stackFullname.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        stackFullname.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        stackFullname.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}

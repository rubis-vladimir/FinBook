//
//  ContactPhotoCell.swift
//  FinBook
//
//  Created by Владимир Рубис on 19.01.2022.
//

import UIKit

class ContactPhotoCell: UICollectionViewCell {
    
    //MARK: - Properties
    static var reuseId: String = "contactPhotoCell"
    
    let photoView = UIImageView()
    let nameLabel = LabelWithPaddingText()
    let surnameLabel = LabelWithPaddingText()
    let fullNameStack = UIStackView()
    
    //MARK: Adding elements to view
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray5
        layer.customizeContactItemView()
        
        setupElements()
        setupConstraints()
    }
    
    //MARK: - Private functions
    private func setupElements() {
        // setup photoView
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.layer.cornerRadius = frame.width / 2 - 10
        photoView.clipsToBounds = true
        
        // setup labels
        let font = UIFont(name: "Avenir", size: 18)
        nameLabel.font = font
        nameLabel.textAlignment = .center
        surnameLabel.font = font
        surnameLabel.textAlignment = .center
        
        // setup stacks
        fullNameStack.addArrangedSubview(surnameLabel)
        fullNameStack.addArrangedSubview(nameLabel)
        
        fullNameStack.translatesAutoresizingMaskIntoConstraints = false
        fullNameStack.axis = .vertical
        fullNameStack.distribution = .fillEqually
        fullNameStack.spacing = 10
        fullNameStack.layer.cornerRadius = 10
        fullNameStack.backgroundColor = .systemGray4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: data filling function
    func configure(with developer: Developer) {
        nameLabel.text = developer.name
        surnameLabel.text = developer.surname
        photoView.image = UIImage(named: developer.photo)
    }
}

// MARK: - Setup Constraints
extension ContactPhotoCell {
    func setupConstraints() {
        let padding: CGFloat = 10
        
        addSubview(photoView)
        addSubview(fullNameStack)
        
        // photoView constraints
        photoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        photoView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding).isActive = true
        photoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding).isActive = true
        photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor).isActive = true
        
        // fullNameStack constraints
        fullNameStack.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: padding).isActive = true
        fullNameStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        fullNameStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding).isActive = true
        fullNameStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding).isActive = true
    }
}

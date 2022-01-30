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
    let nameLabel = BorderedLabel()
    let surnameLabel = BorderedLabel()
    let stackFullname = UIStackView()
    
    static let padding: CGFloat = 10
    static let heightStackFullname: CGFloat = 60
    
    let font = UIFont(name: "Avenir", size: 18)
    
    //MARK: Adding elements to view
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        customizateCell()
        setupConstraints()
    }
    
    //MARK: - Private functions
    private func customizateCell() {
        backgroundColor = .systemGray3
        layer.customizeView()
    }
    
    private func setupElements() {
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
        addSubview(photoView)
        addSubview(stackFullname)
        
        // photoView constraints
        photoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ContactPhotoCell.padding).isActive = true
        photoView.topAnchor.constraint(equalTo: self.topAnchor, constant: ContactPhotoCell.padding).isActive = true
        photoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ContactPhotoCell.padding).isActive = true
        photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor).isActive = true
        
        // stackFullname constraints
        stackFullname.addArrangedSubview(surnameLabel)
        stackFullname.addArrangedSubview(nameLabel)
        stackFullname.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: ContactPhotoCell.padding).isActive = true
        stackFullname.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ContactPhotoCell.padding).isActive = true
        stackFullname.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ContactPhotoCell.padding).isActive = true
        stackFullname.heightAnchor.constraint(equalToConstant: ContactPhotoCell.heightStackFullname).isActive = true
    }
}
//
//  ContactPhotoCell.swift
//  FinBook
//
//  Created by Владимир Рубис on 19.01.2022.
//

import UIKit

// MARK: Класс описывает иконку разработчика в коллекции
class ContactPhotoCell: UICollectionViewCell {
    
    //MARK: - Properties
    static var reuseId: String = "contactPhotoCell"
    
    let photoView = UIImageView()
    let nameLabel = UILabel()
    let surnameLabel = UILabel()
    let fullNameStack = UIStackView()
    
    //MARK: - Override init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public funcs
    /// Настраивает информацию о разработчиках
    ///  - Parameters:
    ///     - developer: экземпляр модели разработчика
    func configure(with developer: Developer) {
        nameLabel.text = developer.name
        surnameLabel.text = developer.surname
        photoView.image = UIImage(named: developer.photo)
    }
    
    //MARK: - Private funcs
    private func setupElements() {
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.layer.cornerRadius = frame.width / 2 - 10
        photoView.clipsToBounds = true
        
        nameLabel.textAlignment = .center
        surnameLabel.textAlignment = .center
        
        fullNameStack.addArrangedSubview(surnameLabel)
        fullNameStack.addArrangedSubview(nameLabel)
        
        fullNameStack.translatesAutoresizingMaskIntoConstraints = false
        fullNameStack.axis = .vertical
        fullNameStack.distribution = .fillEqually
        fullNameStack.spacing = 10
        fullNameStack.layer.cornerRadius = 10
        fullNameStack.backgroundColor = .systemGray4
        
        backgroundColor = .systemGray5
        layer.cornerRadius = 10
    }

    private func setupConstraints() {
        let padding: CGFloat = 10
        
        addSubview(photoView)
        addSubview(fullNameStack)
        
        photoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        photoView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding).isActive = true
        photoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding).isActive = true
        photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor).isActive = true
        
        fullNameStack.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: padding).isActive = true
        fullNameStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        fullNameStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding).isActive = true
        fullNameStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding).isActive = true
    }
}

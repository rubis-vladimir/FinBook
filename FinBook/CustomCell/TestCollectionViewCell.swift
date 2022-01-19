//
//  TestCollectionViewCell.swift
//  FinBook
//
//  Created by Владимир Рубис on 16.12.2021.
//

import UIKit

class TestCollectionViewCell: UICollectionViewCell {
    
    static var reuseId: String = "TestCell"
    
    let photo = UIImageView()
    let fullname = UILabel()
    let email = UILabel()
    let gitHub = UILabel()
    let linkedin = UILabel()
    let stackView = UIStackView()
    
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
        fullname.translatesAutoresizingMaskIntoConstraints = false
        email.translatesAutoresizingMaskIntoConstraints = false
        gitHub.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        linkedin.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(with developer: Developer) {
        fullname.text = developer.surname + " " + developer.name
        email.text = "email: " + developer.email
        gitHub.text = "gitHub: " + developer.gitHub
        linkedin.text = "linkedin: " + developer.linkedin
        photo.image = UIImage(named: developer.photo)
        photo.customizeView(model: <#T##Int#>)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Constraints
extension TestCollectionViewCell {
    func setupConstraints() {
        addSubview(photo)
        addSubview(fullname)
        addSubview(stackView)
//        addSubview(email)
//        addSubview(gitHub)
//        addSubview(linkedin)
        
        // oponentImageView constraints
        photo.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        photo.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        photo.widthAnchor.constraint(equalToConstant: 120).isActive = true
        photo.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        // gradientView constraints
//        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        gradientView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        gradientView.widthAnchor.constraint(equalToConstant: 8).isActive = true
//        gradientView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive  = true
        
        // oponentLabel constraints
        fullname.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        fullname.leadingAnchor.constraint(equalTo: photo.trailingAnchor, constant: 16).isActive = true
//        fullname.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 16).isActive = true
//        email.widthAnchor.constraint(equalToConstant: 60).isActive = true
//        gitHub.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        gitHub.numberOfLines = 0
        // lastMessageLabel constraints
//        lastMessage.topAnchor.constraint(equalTo: friendName.bottomAnchor).isActive = true
//        lastMessage.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16).isActive = true
//        lastMessage.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: -16).isActive =
        stackView.addArrangedSubview(email)
        stackView.addArrangedSubview(gitHub)
        stackView.addArrangedSubview(linkedin)
        stackView.axis = .vertical
//        stackView.alignment =
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        stackView.spacing = 30
    }
}

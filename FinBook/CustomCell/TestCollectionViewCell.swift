//
//  TestCollectionViewCell.swift
//  FinBook
//
//  Created by Владимир Рубис on 16.12.2021.
//

import UIKit

class TestCollectionViewCell: UICollectionViewCell {
    
    let headerLinks: [String] = ["e-mail:", "github:", "linkidin:"]
    static var reuseId: String = "TestCell"
    
    let photoView = UIImageView()
    let nameLabel = BorderedLabel()
    
    let surnameLabel = BorderedLabel()
    let emailLabel = BorderedLabel()
    let gitHubLabel = BorderedLabel()
    let linkedinLabel = BorderedLabel()
    let stackFullname = UIStackView()
    let stackLinks = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 1, alpha: 1)
        setupElements()
        setupStackViewForLink()
        setupConstraints()
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
//        self.backgroundColor = 
    }
    
    func setupStackViewForLink() {
        let linkLabels: [BorderedLabel] = [emailLabel, gitHubLabel, linkedinLabel]
        nameLabel.font = UIFont(name: "Avenir", size: 18)
        surnameLabel.font = UIFont(name: "Avenir", size: 18)
        for (index, label) in linkLabels.enumerated() {
            label.font = UIFont(name: "Avenir", size: 20)
            
            let stackLink = UIStackView()
            let headerLink = UILabel()
            
            headerLink.text = headerLinks[index]
            headerLink.font = UIFont(name: "Avenir", size: 18)
            headerLink.textColor = UIColor.gray
            stackLink.addArrangedSubview(headerLink)
            stackLink.addArrangedSubview(label)
            stackLink.spacing = 1
            stackLink.distribution = .fillEqually
            stackLink.axis = .vertical
            stackLinks.addArrangedSubview(stackLink)
        }
    }
    
    func setupElements() {
        photoView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        surnameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        gitHubLabel.translatesAutoresizingMaskIntoConstraints = false
        linkedinLabel.translatesAutoresizingMaskIntoConstraints = false
        stackFullname.translatesAutoresizingMaskIntoConstraints = false
        stackLinks.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(with developer: Developer) {
        nameLabel.text = developer.name
        surnameLabel.text = developer.surname
        emailLabel.text = developer.email
        gitHubLabel.text = developer.gitHub
        linkedinLabel.text = developer.linkedin
        photoView.image = UIImage(named: developer.photo)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Constraints
extension TestCollectionViewCell {
    func setupConstraints() {
        
        addSubview(photoView)
        addSubview(stackLinks)
        addSubview(stackFullname)
        
        // photo constraints
        photoView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        photoView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoView.widthAnchor.constraint(equalToConstant: self.frame.width / 5).isActive = true
        photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor).isActive = true
        photoView.layer.cornerRadius = self.frame.width / 10
        photoView.layer.masksToBounds = true
        
        // gradientView constraints
//        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        gradientView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        gradientView.widthAnchor.constraint(equalToConstant: 8).isActive = true
//        gradientView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive  = true
        
        // oponentLabel constraints
//        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
//        nameLabel.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 16).isActive = true
//        fullname.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 16).isActive = true
//        email.widthAnchor.constraint(equalToConstant: 60).isActive = true
//        gitHub.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        gitHubLabel.numberOfLines = 0
        gitHubLabel.backgroundColor = .orange
        // lastMessageLabel constraints
//        lastMessage.topAnchor.constraint(equalTo: friendName.bottomAnchor).isActive = true
//        lastMessage.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16).isActive = true
//        lastMessage.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: -16).isActive =
        
        stackFullname.addArrangedSubview(surnameLabel)
        stackFullname.addArrangedSubview(nameLabel)
        stackFullname.axis = .vertical
        stackFullname.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackFullname.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 10).isActive = true
        stackFullname.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackFullname.bottomAnchor.constraint(equalTo: photoView.bottomAnchor).isActive = true
        stackFullname.spacing = 0
        stackFullname.distribution = .fillEqually
        stackFullname.layer.cornerRadius = 10
        stackFullname.backgroundColor = .systemGray4
//        nameLabel.backgroundColor = .orange
//        nameLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
//        surnameLabel.backgroundColor = .orange
        
        
//        stackLinks.addArrangedSubview(emailLabel)
//        stackLinks.addArrangedSubview(gitHubLabel)
//        stackLinks.addArrangedSubview(linkedinLabel)
        stackLinks.axis = .vertical
        stackLinks.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 20).isActive = true
        stackLinks.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackLinks.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackLinks.spacing = 10
        stackLinks.heightAnchor.constraint(equalToConstant:  self.frame.width / 5 * 3).isActive = true
        stackLinks.distribution = .fillEqually
        
        emailLabel.backgroundColor = .systemGray4
        emailLabel.layer.cornerRadius = 10
        emailLabel.clipsToBounds = true
        gitHubLabel.backgroundColor = .systemGray4
            gitHubLabel.layer.cornerRadius = 10
        gitHubLabel.clipsToBounds = true
        linkedinLabel.backgroundColor = .systemGray4
        linkedinLabel.layer.cornerRadius = 10
            linkedinLabel.clipsToBounds = true
        
        
    }
}

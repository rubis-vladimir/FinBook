//
//  TestCollectionViewCell.swift
//  FinBook
//
//  Created by Владимир Рубис on 16.12.2021.
//

import UIKit

class ContactInfoCell: UICollectionViewCell {
    
    static var reuseId: String = "contactInfoCell"
    
    let nameLabel = BorderedLabel()
    let surnameLabel = BorderedLabel()
    let emailLabel = BorderedLabel()
    let gitHubLabel = BorderedLabel()
    let linkedinLabel = BorderedLabel()
    let stackFullname = UIStackView()
    let stackLinks = UIStackView()
    let photoView = UIImageView()
    
    let headerLinks: [String] = ["e-mail:", "github:", "linkidin:"]
    let font = UIFont(name: "Avenir", size: 18)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        setupConstraints()
    }
    
    func setupElements() {
        // disable auto-detection constaints
        photoView.translatesAutoresizingMaskIntoConstraints = false
        stackFullname.translatesAutoresizingMaskIntoConstraints = false
        stackLinks.translatesAutoresizingMaskIntoConstraints = false
        
        // setup labels
        nameLabel.font = font
        surnameLabel.font = font
        setupStackViewForLink()
        
        // setup photoView
        photoView.layer.cornerRadius = self.frame.width / 10
        photoView.layer.masksToBounds = true
        
        // setup stacks
        stackFullname.axis = .vertical
        stackFullname.distribution = .fillEqually
        stackFullname.layer.cornerRadius = 10
        stackFullname.backgroundColor = .systemGray4
        
        stackLinks.axis = .vertical
        stackLinks.distribution = .fillEqually
        stackLinks.spacing = 10
    }
    
    func setupStackViewForLink() {
        let linkLabels: [BorderedLabel] = [emailLabel, gitHubLabel, linkedinLabel]
        
        for (index, label) in linkLabels.enumerated() {
            let stackLink = UIStackView()
            let headerLink = UILabel()
            
            label.customizeLabel()
            
            headerLink.text = headerLinks[index]
            headerLink.font = font
            headerLink.textColor = UIColor.gray
            
            stackLink.addArrangedSubview(headerLink)
            stackLink.addArrangedSubview(label)
            stackLink.distribution = .fillEqually
            stackLink.axis = .vertical
            
            stackLinks.addArrangedSubview(stackLink)
        }
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
extension ContactInfoCell {
    func setupConstraints() {
        addSubview(photoView)
        addSubview(stackLinks)
        addSubview(stackFullname)
        
        // photoView constraints
        photoView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        photoView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoView.widthAnchor.constraint(equalToConstant: self.frame.width / 5).isActive = true
        photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor).isActive = true
        
        // stackFullname constraints
        stackFullname.addArrangedSubview(surnameLabel)
        stackFullname.addArrangedSubview(nameLabel)
        stackFullname.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackFullname.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 10).isActive = true
        stackFullname.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackFullname.bottomAnchor.constraint(equalTo: photoView.bottomAnchor).isActive = true
        
        // stackLinks constraints
        stackLinks.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 20).isActive = true
        stackLinks.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackLinks.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackLinks.heightAnchor.constraint(equalToConstant:  self.frame.width / 5 * 3).isActive = true
        
    }
}

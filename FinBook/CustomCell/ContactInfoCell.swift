//
//  ContactInfoCell.swift
//  FinBook
//
//  Created by Владимир Рубис on 16.12.2021.
//

import UIKit

class ContactInfoCell: UICollectionViewCell {
    
    //MARK: - Properties
    static var reuseId: String = "contactInfoCell"
    
    private let emailLabel = LabelWithPaddingText()
    private let gitHubLabel = LabelWithPaddingText()
    private let linkedinLabel = LabelWithPaddingText()
    private let telegramLabel = LabelWithPaddingText()
    private let stackLinks = UIStackView()
    
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
        layer.customizeContactItemView()
    }
    
    private func setupElements() {
        setupStackViewForLink()
        
        // setup stackLinks
        stackLinks.translatesAutoresizingMaskIntoConstraints = false
        stackLinks.axis = .vertical
        stackLinks.distribution = .fillEqually
        stackLinks.spacing = 10
        stackLinks.layer.cornerRadius = 10
    }
    
    private func setupStackViewForLink() {
        let headerLinks: [String] = ["e-mail:", "github:", "linkidin:", "telegram:"]
        let linkLabels: [LabelWithPaddingText] = [emailLabel, gitHubLabel, linkedinLabel, telegramLabel]
        
        for (index, label) in linkLabels.enumerated() {
            let stackLink = UIStackView()
            let headerLink = UILabel()
            
            label.customizeLinkLabel()
            
            headerLink.text = headerLinks[index]
            headerLink.font = UIFont(name: "Avenir", size: 18)
            headerLink.textColor = UIColor.gray
            
            stackLink.addArrangedSubview(headerLink)
            stackLink.addArrangedSubview(label)
            stackLink.distribution = .fillEqually
            stackLink.axis = .vertical
            
            stackLinks.addArrangedSubview(stackLink)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: data filling function
    func configure(with developer: Developer) {
        emailLabel.text = developer.email
        gitHubLabel.text = developer.gitHub
        linkedinLabel.text = developer.linkedin
        telegramLabel.text = developer.telegram
    }
}

// MARK: - Setup Constraints
extension ContactInfoCell {
    func setupConstraints() {
        let padding: CGFloat = 10
        
        addSubview(stackLinks)
        
        // stackLinks constraints
        stackLinks.topAnchor.constraint(equalTo: self.topAnchor, constant: padding).isActive = true
        stackLinks.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        stackLinks.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding).isActive = true
        stackLinks.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding).isActive = true
    }
}

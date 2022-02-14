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
    private let linksStack = UIStackView()
    
    //MARK: Adding elements to view
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        setupConstraints()
    }
    
    //MARK: - Private functions
    private func setupElements() {
        setupStackViewForLink()
        
        linksStack.translatesAutoresizingMaskIntoConstraints = false
        linksStack.axis = .vertical
        linksStack.distribution = .fillEqually
        linksStack.spacing = 10
        linksStack.layer.cornerRadius = 10
        
        backgroundColor = .systemGray5
        layer.customizeContactItemView()
    }
    
    private func setupStackViewForLink() {
        let headerLinks: [String] = ["e-mail:", "github:", "linkidin:", "telegram:"]
        let linkLabels: [LabelWithPaddingText] = [emailLabel, gitHubLabel, linkedinLabel, telegramLabel]
        
        for (header, label) in zip(headerLinks, linkLabels) {
            let linkStack = UIStackView()
            let headerLinkLabel = UILabel()
            
            label.customizeLinkLabel()
            
            headerLinkLabel.text = header
            headerLinkLabel.font = UIFont(name: "Avenir", size: 18)
            headerLinkLabel.textColor = UIColor.gray
            
            linkStack.addArrangedSubview(headerLinkLabel)
            linkStack.addArrangedSubview(label)
            linkStack.distribution = .fillEqually
            linkStack.axis = .vertical
            
            linksStack.addArrangedSubview(linkStack)
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
        
        addSubview(linksStack)
        
        // stackLinks constraints
        linksStack.topAnchor.constraint(equalTo: self.topAnchor, constant: padding).isActive = true
        linksStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        linksStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding).isActive = true
        linksStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding).isActive = true
    }
}

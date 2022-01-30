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
    
    let emailLabel = BorderedLabel()
    let gitHubLabel = BorderedLabel()
    let linkedinLabel = BorderedLabel()
    let stackLinks = UIStackView()
    
    let headerLinks: [String] = ["e-mail:", "github:", "linkidin:"]
    let font = UIFont(name: "Avenir", size: 18)
    static let padding: CGFloat = 10
    static let heightLink: CGFloat = 60
    
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
        setupStackViewForLink()
        
        stackLinks.translatesAutoresizingMaskIntoConstraints = false
        stackLinks.axis = .vertical
        stackLinks.distribution = .fillEqually
        stackLinks.spacing = 10
    }
    
    private func setupStackViewForLink() {
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: data filling function
    func configure(with developer: Developer) {
        emailLabel.text = developer.email
        gitHubLabel.text = developer.gitHub
        linkedinLabel.text = developer.linkedin
    }
}

// MARK: - Setup Constraints
extension ContactInfoCell {
    func setupConstraints() {
        addSubview(stackLinks)
        
        // stackLinks constraints
        stackLinks.topAnchor.constraint(equalTo: self.topAnchor, constant: ContactInfoCell.padding).isActive = true
        stackLinks.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ContactInfoCell.padding).isActive = true
        stackLinks.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ContactInfoCell.padding).isActive = true
        stackLinks.heightAnchor.constraint(equalToConstant: ContactInfoCell.heightLink * 3 + stackLinks.spacing * 2).isActive = true
    }
}

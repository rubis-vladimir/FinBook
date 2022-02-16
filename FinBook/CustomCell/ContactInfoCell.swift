//
//  ContactInfoCell.swift
//  FinBook
//
//  Created by Владимир Рубис on 16.12.2021.
//

import UIKit

enum TypeURL {
    case email
    case telegram
    case browser
}

class ContactInfoCell: UICollectionViewCell {
    
    //MARK: - Properties
    static var reuseId: String = "contactInfoCell"
    
    private let defaultLabel = UILabel()
    
    private let emailTextView = UITextView()
    private let gitHubTextView = UITextView()
    private let linkedinTextView = UITextView()
    private let telegramTextView = UITextView()
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
        
        defaultLabel.setupDefaultLabel(view: self,
                                       title: "Для отображения контактной информации разработчика нажмите на соответствующую карточку",
                                       inCenter: false)
        
        layer.cornerRadius = 10
    }
    
    private func setupStackViewForLink() {
        let headerLinks: [String] = ["e-mail:", "github:", "linkidin:", "telegram:"]
        let linkLabels: [UITextView] = [emailTextView, gitHubTextView, linkedinTextView, telegramTextView]
        
        for (header, label) in zip(headerLinks, linkLabels) {
            let linkStack = UIStackView()
            let headerLinkLabel = UILabel()
            
            label.backgroundColor = .systemGray4
            label.layer.cornerRadius = 10
            headerLinkLabel.text = header
            headerLinkLabel.textColor = UIColor.systemGray
            
            linkStack.addArrangedSubview(headerLinkLabel)
            linkStack.addArrangedSubview(label)
            linkStack.distribution = .fillEqually
            linkStack.axis = .vertical
            
            linksStack.addArrangedSubview(linkStack)
        }
        
        linksStack.translatesAutoresizingMaskIntoConstraints = false
        linksStack.axis = .vertical
        linksStack.distribution = .fillEqually
        linksStack.spacing = 10
        linksStack.layer.cornerRadius = 10
    }
    
    
    private func getLink(_ string: String, type: TypeURL) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: string)
        var startPartURL: String = ""
        switch type {
        case .email:
            startPartURL = "mailto:"
        case .telegram:
            startPartURL = "https://t.me/"
        default:
            startPartURL = "https://www."
        }
        attributedString.addAttribute(.link,
                                      value: "\(startPartURL)" + "\(string)",
                                      range: NSRange(location: 0, length: string.count))
        return attributedString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: data filling function
    func configure(with developer: Developer) {
        emailTextView.attributedText = getLink(developer.links.email, type: .email)
        gitHubTextView.attributedText = getLink(developer.links.gitHub, type: .browser)
        linkedinTextView.attributedText = getLink(developer.links.linkedin, type: .browser)
        telegramTextView.attributedText = getLink(developer.links.telegram, type: .telegram)
    }
    
    func updateCell(_ isSelected: Bool) {
        defaultLabel.isHidden = isSelected ? true : false
        linksStack.isHidden = isSelected ?  false : true
        backgroundColor = isSelected ? .systemGray5 : UIColor.Palette.background
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

//
//  ContactInfoCell.swift
//  FinBook
//
//  Created by Владимир Рубис on 16.12.2021.
//

import UIKit

// MARK: Класс описывает окно контактной информации в коллекции
class ContactInfoCell: UICollectionViewCell {
    
    /// Типы ссылок
    private enum TypeURL: String {
        case email = "mailto:"
        case telegram = "https://t.me/"
        case browser = "https://www."
    }
    
    //MARK: - Properties
    static var reuseId: String = "contactInfoCell"
    
    private let defaultLabel = UILabel()
    
    private let emailTextView = UITextView()
    private let gitHubTextView = UITextView()
    private let linkedinTextView = UITextView()
    private let telegramTextView = UITextView()
    private let linksStack = UIStackView()
    
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
    /// Устанавливает ссылки для текстовых вью
    ///  - Parameters:
    ///     - developer: экземпляр модели разработчика
    func configure(with developer: Developer) {
        emailTextView.attributedText = getLink(from: developer.links.email, type: .email)
        gitHubTextView.attributedText = getLink(from: developer.links.gitHub, type: .browser)
        linkedinTextView.attributedText = getLink(from: developer.links.linkedin, type: .browser)
        telegramTextView.attributedText = getLink(from: developer.links.telegram, type: .telegram)
    }
    
    /// Обновляет `Item`
    ///  - Parameters:
    ///     - isSelected: выбран или нет
    func updateCell(_ isSelected: Bool) {
        defaultLabel.isHidden = isSelected ? true : false
        linksStack.isHidden = isSelected ?  false : true
        backgroundColor = isSelected ? .systemGray5 : Palette.background
    }
    
    //MARK: - Private funcs
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
    
    private func setupConstraints() {
        let padding: CGFloat = 10
        
        addSubview(linksStack)
        
        linksStack.topAnchor.constraint(equalTo: self.topAnchor, constant: padding).isActive = true
        linksStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        linksStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding).isActive = true
        linksStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding).isActive = true
    }
    
    /// Добавляет в аттрибуты `UITextView` переходы по ссылкам
    ///   - Parameters:
    ///     - string: текст ссылки
    ///     - type: тип ссылки
    ///   -    Returns: обновленные аттрибуты
    private func getLink(from string: String, type: TypeURL) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: string)
        let startPartURL: String = type.rawValue
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17),
            .link: "\(startPartURL)" + "\(string)"
        ]
        let range = NSRange(location: 0, length: string.count)
        
        attributedString.setAttributes(attributes, range: range)
    
        return attributedString
    }
}

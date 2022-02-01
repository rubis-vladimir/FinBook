//
//  BorderedLabel.swift
//  FinBook
//
//  Created by Владимир Рубис on 20.01.2022.
//

import UIKit

class LabelWithPaddingText: UILabel {
    
    private let sidePadding: CGFloat = 10
    private let radius: CGFloat = 10
    private let customFont = UIFont(name: "Avenir", size: 20)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: sidePadding, dy: 0))
        invalidateIntrinsicContentSize()
    }
    
    func customizeLinkLabel() {
        backgroundColor = .systemGray4
        layer.cornerRadius = radius
        clipsToBounds = true
        font = customFont
        numberOfLines = 0
    }
}

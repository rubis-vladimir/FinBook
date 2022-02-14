//
//  LabelWithPaddingText.swift
//  FinBook
//
//  Created by Владимир Рубис on 20.01.2022.
//

import UIKit

class LabelWithPaddingText: UILabel {

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: 10, dy: 0))
        invalidateIntrinsicContentSize()
    }
    
    func customizeLinkLabel() {
        backgroundColor = .systemGray4
        layer.cornerRadius = 10
        clipsToBounds = true
        font = UIFont(name: "Avenir", size: 20)
        numberOfLines = 0
    }
}

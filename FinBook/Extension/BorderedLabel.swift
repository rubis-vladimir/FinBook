//
//  BorderedLabel.swift
//  FinBook
//
//  Created by Владимир Рубис on 20.01.2022.
//

import UIKit

class BorderedLabel: UILabel {
    
    var sidePadding = CGFloat(10)
    
    override func sizeToFit() {
        super.sizeToFit()
        bounds.size.width += 2 * sidePadding
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: sidePadding, dy: 0))
        invalidateIntrinsicContentSize()
    }
    
    func customizeLabel() {
        backgroundColor = .systemGray4
        layer.cornerRadius = 10
        clipsToBounds = true
        font = UIFont(name: "Avenir", size: 20)
        numberOfLines = 0
    }
}

//
//  BusinessCardView.swift
//  FinBook
//
//  Created by Владимир Рубис on 12.12.2021.
//

import UIKit

class ContactView: UIView {
    
    //    private let hexColors = ["EAE5C9", "6CC6CB"]
    //    private let hexColors = ["7DC387", "DBE9EA"]
    //    private let hexColors = ["50D5B7", "067D68"]
    private let hexColors = ["A1D6E2", "1995AD"]
    private struct Constants {
        //        static let photoSize = bounds.height
    }
    
    func draw(_ rect: CGRect, developer: Developer, isSelected: Bool) {
        
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        let color1 = ColorManager.shared.hexStringToUIColor(hex: hexColors[0])
        let color2 = ColorManager.shared.hexStringToUIColor(hex: hexColors[1])
        self.addHorizontalGradientLayer(leftColor: color1, rightColor: color2)
        //        self.layer.shadowColor = UIColor.black.cgColor
        //        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        //        self.layer.shadowOpacity = 0.7
        //        self.layer.shadowRadius = 5
        addPhotoView(developer, isSelected: true)
        addFullnameLabel(developer, isSelected: true)
    }
    
    private func addPhotoView(_ developer: Developer, isSelected: Bool) {
        let photoView = UIImageView()
        let photoSize: CGFloat
        if isSelected {
            photoSize = self.bounds.height * 0.7
        } else {
            photoSize = self.bounds.height * 0.2
        }
        let y = self.bounds.height * 0.15
        photoView.layer.cornerRadius = 10
        photoView.layer.masksToBounds = true
        photoView.frame = CGRect(x: 20, y: y, width: photoSize, height: photoSize)
        photoView.image = UIImage(named: developer.photo)
        self.addSubview(photoView)
    }
    
    private func addFullnameLabel(_ developer: Developer, isSelected: Bool) {
        let fullnameLabel = UILabel()
        fullnameLabel.frame = CGRect(x: self.bounds.width / 2, y: self.bounds.height / 2 - 50, width: self.bounds.width / 2 - 10, height: self.bounds.height / 2)
        fullnameLabel.numberOfLines = 0
        fullnameLabel.text = developer.surname + " " + developer.name
        fullnameLabel.font = UIFont(name: "Avenir Heavy", size: 20)
        fullnameLabel.textAlignment = .center
        self.addSubview(fullnameLabel)
    }
}

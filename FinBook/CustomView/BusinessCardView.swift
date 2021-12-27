//
//  BusinessCardView.swift
//  FinBook
//
//  Created by Владимир Рубис on 12.12.2021.
//

import UIKit

class BusinessCardView: UIView {

    func draw(_ rect: CGRect, developers: [Developer]) {
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 10
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
//        self.layer.shadowOpacity = 0.7
//        self.layer.shadowRadius = 5
        addPhotoView()
        addFullnameLabel()
    }
    
    private func addPhotoView() {
        let photoView = UIImageView()
        let photoSize = self.bounds.height * 0.7
        let y = self.bounds.height * 0.15
        
        photoView.frame = CGRect(x: 20, y: y, width: photoSize, height: photoSize)
        photoView.image = UIImage(named: "testPhoto")
        self.addSubview(photoView)
  }
    
    private func addFullnameLabel() {
        let fullnameLabel = UILabel()
        fullnameLabel.frame = CGRect(x: self.bounds.width / 2, y: self.bounds.height / 2 - 50, width: self.bounds.width / 2 - 10, height: self.bounds.height / 2)
        fullnameLabel.numberOfLines = 0
        fullnameLabel.text = "Рубис Владимир \nЮрьевич"
        fullnameLabel.font = UIFont(name: "Avenir Heavy", size: 20)
        fullnameLabel.textAlignment = .center
        self.addSubview(fullnameLabel)
    }
}

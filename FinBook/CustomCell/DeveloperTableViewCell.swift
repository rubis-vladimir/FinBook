//
//  DeveloperTableViewCell.swift
//  FinBook
//
//  Created by Владимир Рубис on 13.12.2021.
//

import UIKit

class DeveloperTableViewCell: UITableViewCell {

    
    @IBOutlet weak var contactView: ContactView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.frame.height = 50
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  SettingsViewController.swift
//  FinBook
//
//  Created by Владимир Рубис on 28.12.2021.
//

import UIKit

class SettingsViewController: UITableViewController {

    
    @IBOutlet weak var nameTheme: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source


    @IBAction func changeColorTheme(_ sender: UISwitch) {
    }
    
    
    @IBAction func editCategories(_ sender: UIButton) {
    }
}

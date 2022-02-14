//
//  SettingsViewController.swift
//  FinBook
//
//  Created by Владимир Рубис on 28.12.2021.
//

import UIKit

class SettingsViewController: UITableViewController {

    
    @IBOutlet weak var themeSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themeSegmentedControl.tintColor = UIColor.Palette.black
        themeSegmentedControl.selectedSegmentIndex = Theme.current.rawValue
        themeSegmentedControl.addTarget(self, action: #selector(selectTheme), for: .valueChanged)
        
        view.backgroundColor = UIColor.Palette.background
    }
    
    @objc func selectTheme() {
        guard let theme = Theme(rawValue: themeSegmentedControl.selectedSegmentIndex) else { return }
        
        theme.setActive()
        Notification.Name(rawValue: "didReceiveNotification")
    }
}

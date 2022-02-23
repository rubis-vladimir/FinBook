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
        
        setupElements()
    }
    
    @objc func selectTheme() {
        guard let theme = Theme(rawValue: themeSegmentedControl.selectedSegmentIndex) else { return }
        theme.setActive()
    }
    
    private func setupElements() {
        themeSegmentedControl.selectedSegmentIndex = Theme.current.rawValue
        themeSegmentedControl.addTarget(self, action: #selector(selectTheme), for: .valueChanged)
        
        view.backgroundColor = Palette.background
    }
}

//
//  SettingsViewController.swift
//  FinBook
//
//  Created by Владимир Рубис on 28.12.2021.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    var numberOfTheme: Int = 0
    
    @IBOutlet weak var nameThemeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var themeView: UIView!
    @IBOutlet weak var categoryView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        ColorManager.shared.setThemeColors(mainElement: self.view, secondaryElement: navigationController?.navigationBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    private func setupElements() {
        themeView.customizeView(model: 2)
        categoryView.customizeView(model: 2)
        
        nameThemeLabel.changeColor()
        categoryLabel.changeColor()
        
        numberOfTheme = ColorManager.shared.retrieveThemeData()
        themeSwitch.isOn = numberOfTheme == 0 ? false : true
    }
    
    // MARK: - Table view data source


    @IBAction func changeColorTheme(_ sender: UISwitch) {
        numberOfTheme = sender.isOn ? 1 : 0
        
        ColorManager.shared.saveThemeData(value: numberOfTheme)
        
        nameThemeLabel.changeColor()
        categoryLabel.changeColor()
        ColorManager.shared.setThemeColors(mainElement: self.view, secondaryElement: navigationController?.navigationBar)
    }
    
    
    @IBAction func editCategories(_ sender: UIButton) {
    }
}

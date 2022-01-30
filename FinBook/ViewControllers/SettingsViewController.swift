//
//  SettingsViewController.swift
//  FinBook
//
//  Created by Владимир Рубис on 28.12.2021.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    var numberOfTheme: Int = 0
    
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
        
        numberOfTheme = UserDefaultManager.shared.retrieveThemeData()
        themeSwitch.isOn = numberOfTheme == 0 ? true : false
    }
    
    // MARK: - Table view data source


    @IBAction func changeColorTheme(_ sender: UISwitch) {
        numberOfTheme = sender.isOn ? 0 : 1
        
        UserDefaultManager.shared.saveThemeData(value: numberOfTheme)
        ColorManager.shared.setThemeColors(mainElement: self.view, secondaryElement: navigationController?.navigationBar)
    }
    
    
    @IBAction func editCategories(_ sender: UIButton) {
    }
}

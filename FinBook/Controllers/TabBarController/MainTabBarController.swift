//
//  MainTabBarController.swift
//  FinBook
//
//  Created by Владимир Рубис on 13.07.2021.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    /// Перерисовывает `tabBar` для выбранного `item`
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let tB = tabBar as? CustomTabBar else { return }
        tB.draw(tabBar.bounds)
    }
}


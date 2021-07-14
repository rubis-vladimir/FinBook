//
//  MainTabBarController.swift
//  FinBook
//
//  Created by Владимир Рубис on 13.07.2021.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidAppear(_ animated: Bool) {
        self.delegate = self
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is
    }
}

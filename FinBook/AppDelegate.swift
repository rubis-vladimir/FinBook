//
//  AppDelegate.swift
//  FinBook
//
//  Created by Владимир Рубис on 11.07.2021.
//

import UIKit

//let themeWindow = ThemeWindow()

final class ThemeWindow: UIWindow {
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        // Если текущая тема системная и поменяли оформление в iOS, опять меняем тему на системную.
        // Например: Пользователь поменял светлое оформление на темное.
        if Theme.current == .system {
            DispatchQueue.main.async {
                Theme.system.setActive()
            }
        }
    }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func applicationWillTerminate(_ application: UIApplication) {
        StorageManager.shared.saveContext()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NotificationCenter.default.post(Notification(name: Notification.Name("didReceiveNotification")))
        return true
    }
    internal func applicationDidBecomeActive(_ application: UIApplication) {
        NotificationCenter.default.post(Notification(name: Notification.Name("didReceiveNotification")))
    }
}

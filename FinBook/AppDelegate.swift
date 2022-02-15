//
//  AppDelegate.swift
//  FinBook
//
//  Created by Владимир Рубис on 11.07.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func applicationWillTerminate(_ application: UIApplication) {
        StorageManager.shared.saveContext()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NotificationCenter.default.post(Notification(name: Notification.Name("didReceiveNotification")))
        DispatchQueue.main.async {
            Theme.current.setActive()
        }
        return true
    }
    internal func applicationDidBecomeActive(_ application: UIApplication) {
        NotificationCenter.default.post(Notification(name: Notification.Name("didReceiveNotification")))
    }
}

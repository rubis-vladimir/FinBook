//
//  Theme.swift
//  FinBook
//
//  Created by Владимир Рубис on 06.02.2022.
//

import UIKit

enum Theme: Int, CaseIterable {
    case system = 0
    case light
    case dark
}

extension Theme {
    
    @Persist(key: "app_theme", defaultValue: Theme.system.rawValue)
    private static var appTheme: Int
    
    // Сохранение темы в UserDefaults
    func save() {
        Theme.appTheme = self.rawValue
    }
    
    // Текущая тема приложения
    static var current: Theme {
       Theme(rawValue: appTheme) ?? .system
    }
}

extension Theme {
    
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light: return .light
        case .dark: return .dark
        case .system: return .unspecified
        }
    }
    

    
    func setActive() {
        // Сохраняем активную тему
        save()
        
        NotificationCenter.default.post(Notification(name: Notification.Name("didReceiveNotification")))
        
        // Устанавливаем активную тему для всех окон приложения
        UIApplication.shared.windows
            .forEach { $0.overrideUserInterfaceStyle = userInterfaceStyle }
        
        
    }
}


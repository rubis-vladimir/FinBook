//
//  Theme.swift
//  FinBook
//
//  Created by Владимир Рубис on 06.02.2022.
//

import UIKit

enum Theme: Int, CaseIterable {
    case system, light, dark
}

extension Theme {
    // Обертка свойства для сохранения в UserDefaults
    @Persist(key: "app_theme", defaultValue: Theme.system.rawValue)
    private static var appTheme: Int
    
    // Сохранение активной темы
    private func save() {
        Theme.appTheme = self.rawValue
    }
    
    // Текущая тема в приложении
    static var current: Theme {
       Theme(rawValue: appTheme) ?? .system
    }
}

// MARK: - Save and Update theme in App

extension Theme {
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light: return .light
        case .dark: return .dark
        case .system: return .unspecified
        }
    }
    
    func setActive() {
        save()
        
        // Устанавливаем активную тему для всех окон приложения
        UIApplication.shared.windows
            .forEach { $0.overrideUserInterfaceStyle = userInterfaceStyle }
    }
}


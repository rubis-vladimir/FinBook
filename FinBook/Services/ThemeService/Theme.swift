//
//  Theme.swift
//  FinBook
//
//  Created by Владимир Рубис on 06.02.2022.
//


/// Нужно будет все задокументировать

import UIKit

// MARK: - Сохраняет и обновляет цветовую тему приложения
enum Theme: Int, CaseIterable {
    case system, light, dark
}


extension Theme {
    /// Обертка свойства `appTheme` для сохранения в UserDefaults
    @Persist(key: "app_theme",
             defaultValue: Theme.system.rawValue)
    private static var appTheme: Int
    
    /// Сохраняет выбранное значение свойства
    private func save() {
        Theme.appTheme = self.rawValue
    }
    
    /// Текущая тема приложения
    static var current: Theme {
       Theme(rawValue: appTheme) ?? .system
    }
}


extension Theme {
    /// Стиль интерфейса в зависимости от кейса
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light: return .light /// светлый
        case .dark: return .dark /// темный
        case .system: return .unspecified /// установленный системно в приложении
        }
    }
    
    /// Устанавливает стиль интерфейса приложения и
    /// сохраняет выбранную тему в UserDefaults
    func setActive() {
        save()
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        
        guard let windows = windowScenes?.windows else { return }
        windows.forEach { $0.overrideUserInterfaceStyle = userInterfaceStyle }
    }
}


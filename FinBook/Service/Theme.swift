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
    @Persist(key: "app_theme", defaultValue: Theme.system.rawValue)
    private static var appTheme: Int
    
    private func save() {
        Theme.appTheme = self.rawValue
    }
    
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
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        guard let windows = windowScenes?.windows else { return }
        
        windows.forEach { $0.overrideUserInterfaceStyle = userInterfaceStyle }
    }
}


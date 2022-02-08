////
////  Theme.swift
////  FinBook
////
////  Created by Владимир Рубис on 06.02.2022.
////
//
//import UIKit
//
//enum Theme: Int, CaseIterable {
////    case system = 0
//    case light
//    case dark
//}
//
//extension Theme {
//    
//    @Persist(key: "app_theme", defaultValue: Theme.light.rawValue)
//    private static var appTheme: Int
//    
//    // Сохранение темы в UserDefaults
//    func save() {
//        Theme.appTheme = self.rawValue
//    }
//    
//    // Текущая тема приложения
//    static var current: Theme {
//        Theme(rawValue: appTheme) ?? .light
//    }
//}
//
//extension Theme {
//    
//    @available(iOS 13.0, *)
//    var userInterfaceStyle: UIUserInterfaceStyle {
//        switch self {
//        case .light: return .light
//        case .dark: return .dark
//        }
//    }
//    
//    func setActive() {
//        // Сохраняем активную тему
//        save()
//        
////        guard #available(iOS 13.0, *) else { return }
//        
//        // Устанавливаем активную тему для всех окон приложения
////        UIApplication.shared.windows
////        UIWindowScene.
////            .forEach { $0.overrideUserInterfaceStyle = userInterfaceStyle }
//    }
//}
//

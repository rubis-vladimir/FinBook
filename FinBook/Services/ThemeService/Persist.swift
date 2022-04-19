////
////  Persist.swift
////  FinBook
////
////  Created by Владимир Рубис on 06.02.2022.
////
//
import Foundation

// MARK: - Обертка свойства для сохранения в UserDefaults
@propertyWrapper
struct Persist<T> {
    let key: String
    let defaultValue: T
    
    /// Устанавливает значение свойства по ключу / по умолчанию
    /// При изменении значения обновляет его в `UserDefaults`
    var wrappedValue: T {
        get { UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
    
    /// Инициализатор
    ///  - Parameters:
    ///     - key: ключ
    ///     - defaultValue: значение по умолчанию
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

////
////  Persist.swift
////  FinBook
////
////  Created by Владимир Рубис on 06.02.2022.
////
//
import Foundation

// MARK: - Saving in UserDefaults
@propertyWrapper
struct Persist<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get { UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

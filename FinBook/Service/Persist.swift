////
////  Persist.swift
////  FinBook
////
////  Created by Владимир Рубис on 06.02.2022.
////
//
import Foundation

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

//class StorageManager {
//    static let shared = StorageManager()
//
//    private let userDefaults = UserDefaults.standard
//    private let key = "transaction"
//
//    private init() {}
//
//    func save(transaction: Transaction) {
//        var transactions = fetchTransactions()
//        transactions.append(transaction)
//        guard let data = try? JSONEncoder().encode(transactions) else { return }
//        userDefaults.set(data, forKey: key)
//    }
//
//    func fetchTransactions() -> [Transaction] {
//        guard let data = userDefaults.object(forKey: key) as? Data else { return [] }
//        guard let contacts = try? JSONDecoder().decode([Transaction].self, from: data) else { return [] }
//        return contacts
//    }
//
//    func deleteTransaction(at index: Int) {
//        var transactions = fetchTransactions()
//        transactions.remove(at: index)
//        userDefaults.set(transactions, forKey: key)
//    }
//}

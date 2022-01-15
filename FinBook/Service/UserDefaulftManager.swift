//
//  UserDefaulftManager.swift
//  FinBook
//
//  Created by Владимир Рубис on 15.01.2022.
//

import Foundation

class UserDefaultManager {
    
    static let shared = UserDefaultManager()
    
    private let userDefaults = UserDefaults.standard
    private let key1 = "theme"
    //    private let key2 = "category"
    
    //    private init() {}
    
    // MARK: - Saving theme data to User Defaults
    
    func saveThemeData(value: Int) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key1)
    }
    
    // MARK: - Retrieving theme data from User Defaults
    
    func retrieveThemeData() -> Int{
        let defaults = UserDefaults.standard
        guard let savedValue = defaults.value(forKey: key1) else { return 0 }
        return savedValue as! Int
    }
    
    //
    //     func save(transaction: Transaction) {
    //         var transactions = fetchTransactions()
    //         transactions.append(transaction)
    //         guard let data = try? JSONEncoder().encode(transactions) else { return }
    //         userDefaults.set(data, forKey: key2)
    //     }
    //
    //     func fetchTransactions() -> [Transaction] {
    //         guard let data = userDefaults.object(forKey: key2) as? Data else { return [] }
    //         guard let contacts = try? JSONDecoder().decode([Transaction].self, from: data) else { return [] }
    //         return contacts
    //     }
    //
    //     func deleteTransaction(at index: Int) {
    //         var transactions = fetchTransactions()
    //         transactions.remove(at: index)
    //         userDefaults.set(transactions, forKey: key2)
    //     }
}

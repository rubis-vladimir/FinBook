//
//  StorageManager.swift
//  FinBook
//
//  Created by Сперанский Никита on 08.09.2021.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let key = "transaction"
    
    private init() {}
    
    func save(transaction: Transaction) {
        var transactions = fetchTransactions()
        transactions.append(transaction)
        guard let data = try? JSONEncoder().encode(transactions) else { return }
        userDefaults.set(data, forKey: key)
    }
    
    func fetchTransactions() -> [Transaction] {
        guard let data = userDefaults.object(forKey: key) as? Data else { return [] }
        guard let contacts = try? JSONDecoder().decode([Transaction].self, from: data) else { return [] }
        return contacts
    }
    
    func deleteTransaction(at index: Int) {
        var transactions = fetchTransactions()
        transactions.remove(at: index)
        userDefaults.set(transactions, forKey: key)
    }
}

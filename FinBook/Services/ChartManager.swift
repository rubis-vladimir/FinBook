//
//  ChartManager.swift
//  FinBook
//
//  Created by Владимир Рубис on 28.11.2021.
//

import UIKit

class ChartManager {
    
    static let shared = ChartManager()
    
    // MARK: The function returns a filltered array - (category, percent)
    func fillteredForChart(startDate: Date, finishDate: Date, isIncome: Bool) -> [(String, Double)] {
        
        let transactions = StorageManager.shared.fetchData()
        
        let calendar = Calendar.current
        var transactDictionary: [String: Double] = [:]
        
        for transact in transactions {
            guard let date = transact.date else { continue }
            
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
            let finishComponents = calendar.dateComponents([.year, .month, .day], from: finishDate)
            let startComponents = calendar.dateComponents([.year, .month, .day], from: startDate)
            
            guard let date = calendar.date(from: dateComponents),
                  let finish = calendar.date(from: finishComponents),
                  let start = calendar.date(from: startComponents),
                  transact.incomeTransaction == isIncome,
                  (date >= start && date <= finish) else { continue }
            
            if let key = transact.category, var keyExists = transactDictionary[key] {
                keyExists += transact.cost
                transactDictionary[key] = keyExists
            } else {
                transactDictionary[transact.category ?? "Прочее"] = transact.cost
            }
        }
        
        let summTransactions = transactDictionary.map{$1}.reduce(0, +)
        
        return pairs(from: transactDictionary).map{(k,v) in (k, v * 100 / summTransactions)}
    }
    
    private func pairs<Key, Value: Comparable>(from dictionary: [Key: Value]) -> [(Key, Value)] {
        return Array(dictionary).sorted(by: {$0.1 > $1.1})
    }
}

//
//  ChartManager.swift
//  FinBook
//
//  Created by Владимир Рубис on 28.11.2021.
//

import UIKit

class ChartManager {
    
    static let shared = ChartManager()
    
    func fillteredForChart(transactions: [Transact], start: Date, finish: Date) -> [(String, Double)] {
        var chartTransact: [String: Double] = [:]
        
        for transact in transactions {
            if let date = transact.date, !transact.incomeTransaction {
                let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
                let finishComponents = Calendar.current.dateComponents([.year, .month, .day], from: finish)
                let startComponents = Calendar.current.dateComponents([.year, .month, .day], from: start)
                
                if let date = Calendar.current.date(from: dateComponents),
                   let finish = Calendar.current.date(from: finishComponents),
                   let start = Calendar.current.date(from: startComponents),
                   date >= start && date <= finish {
                    if let key = transact.category, var keyExists = chartTransact[key] {
                        keyExists += transact.cost
                        chartTransact[key] = keyExists
                    } else {
                        chartTransact[transact.category ?? "Прочее"] = transact.cost
                        print(transact.category ?? "Прочее")
                    }
                }
            }
        }
        let summExpenses = chartTransact.map{$1}.reduce(0, +)
//        return Dictionary(uniqueKeysWithValues: chartTransact.lazy.map{(k, v) in (k, v * 2 * Double.pi / summExpenses)})
        return Array(chartTransact.map{(k,v) in (k, v * 2 * Double.pi / summExpenses)}).sorted(by:{$0.1 > $1.1})
    }
}

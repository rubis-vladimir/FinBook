//
//  ChartManager.swift
//  FinBook
//
//  Created by Владимир Рубис on 28.11.2021.
//

import UIKit

class ChartManager {
    
    private var transactions: [Transact] = []
//    private var chartTransact: [String: Double] = [:]
    //временно
    private let month = 11
    
    static let shared = ChartManager()
    
    func fillteredForChart(transactions: [Transact]) -> [String: Double] {
//    period: String, selectedInterval: String)
//        getData()
        var chartTransact: [String: Double] = [:]
        
        for transact in transactions {
        let month = Calendar.current.component(.month, from: transact.date ?? Date())
            if month == self.month {
//                if transact.category ==
//                chartTransact[transact.category ?? "Прочее"] += transact.cost
                if let key = transact.category, var keyExists = chartTransact[key] {
                    keyExists += transact.cost
//                    chartTransact.updateValue(keyExists, forKey: key)
                    chartTransact[key] = keyExists
                    print(key)
                    print(chartTransact)
                } else {
//                    chartTransact.updateValue(transact.cost, forKey: transact.category ?? "Прочее")
                    chartTransact[transact.category ?? "Прочее"] = transact.cost
                    print(transact.category ?? "Прочее")
                }
            }
        }
        return chartTransact
        
//        guard transactions != [] else { return }
//        chartTransact = transactions.filter($0.date?.m)
//        switch period {
//        case "месяц":
//            chartTransact = transactions.filter()
//        case "год":
//        default
//        default:
//            print("1")
//        }
//        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: transactions[0].date!)

    }
    
    
    private func getData() {
        StorageManager.shared.fetchData { result in
            switch result {
            case .success(let transactions):
                self.transactions = transactions
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

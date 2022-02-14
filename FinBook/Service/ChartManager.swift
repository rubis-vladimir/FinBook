//
//  ChartManager.swift
//  FinBook
//
//  Created by Владимир Рубис on 28.11.2021.
//

import UIKit

class ChartManager {
    
    static let shared = ChartManager()
    
    // MARK: The function returns a filltered array of tuples - (category, percent)
    func fillteredForChart(startDate: Date, finishDate: Date, isIncome: Bool) -> [(String, Double)] {
        // Получаем данные из CoreData
        let transactions = StorageManager.shared.fetchData()
        
        // Создаем и рассчитываем словарь - [категория: сумма] за указанный период времени
        let calendar = Calendar.current
        var chartTransact: [String: Double] = [:]
        
        for transact in transactions {
            if let date = transact.date, transact.incomeTransaction == isIncome {
                let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
                let finishComponents = calendar.dateComponents([.year, .month, .day], from: finishDate)
                let startComponents = calendar.dateComponents([.year, .month, .day], from: startDate)
                
                if let date = calendar.date(from: dateComponents),
                   let finish = calendar.date(from: finishComponents),
                   let start = calendar.date(from: startComponents),
                   date >= start && date <= finish {
                    if let key = transact.category, var keyExists = chartTransact[key] {
                        keyExists += transact.cost
                        chartTransact[key] = keyExists
                    } else {
                        chartTransact[transact.category ?? "Прочее"] = transact.cost
                    }
                }
            }
        }
        // Рассчитываем общую сумму операций за указанный период времени
        let summExpenses = chartTransact.map{$1}.reduce(0, +)
        
        // Возвращаем отсортированный массив кортежей - (категория, процент)
        return Array(chartTransact.map{(k,v) in (k, v * 100 / summExpenses)})
            .sorted(by:{$0.1 > $1.1})
    }
}

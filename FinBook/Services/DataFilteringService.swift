//
//  DataFilteringService.swift
//  FinBook
//
//  Created by Владимир Рубис on 28.11.2021.
//

import UIKit

// MARK: Сервис получения данных о затратах/доходах за выбранный период
final class DataFilteringService {
    
    /// Получает данные за выбранный период
    ///  - Parameters:
    ///     - transactions: транзакции
    ///     - startDate: начальная дата
    ///     - finishDate: конечная дата
    ///     - isIncome: доход/расход
    ///  - Returns: отфильтрованный и отсортированный по `cost`
    ///  массив кортежей (категория, процент от общей стоимости)
    func getDataInPercentage(from transactions: [Transact],
                 from startDate: Date,
                 to endDate: Date,
                 isIncome: Bool) -> [(String, Double)] {
        
        var transactDictionary: [String: Double] = [:]
        
        for transact in transactions {
            /// Пробуем получить дату из транзакции
            guard let dateTransact = transact.date else { continue }
            
            /// Преобразовываем формат дат
            /// (для корректной фильтрации по дате, без учета времени)
            let date = changeDateFormat(for: dateTransact)
            let start = changeDateFormat(for: startDate)
            let end = changeDateFormat(for: endDate)
            
            /// Фильтруем по типу и дате
            guard transact.incomeTransaction == isIncome,
                  (date >= start && date <= end) else { continue }
            
            /// Создаем ключ по категории и добавляем данные
            /// по стоимости транзакций в словарь
            if let key = transact.category,
               var keyExists = transactDictionary[key] {
                keyExists += transact.cost
                transactDictionary[key] = keyExists
            } else {
                transactDictionary[transact.category ?? "Прочее"] = transact.cost
            }
        }
        
        /// Рассчитываем стоимость всех транзакций за выбранный период
        let totalCostOfTransactions = transactDictionary.map{$1}.reduce(0, +)
        
        /// Преобразуем словарь в отсортированный по `cost` массив кортежей
        let sortedArray = pairs(from: transactDictionary)
        
        /// Преобразуем `cost` в `percent`
        let sortedArrayWithPercent = sortedArray.map{(category, value) in
            (category, value * 100 / totalCostOfTransactions)}
        
        return sortedArrayWithPercent
    }
    
    /// Преобразует формат даты в yyyy-MM-dd
    private func changeDateFormat(for date: Date) -> Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let newDate = calendar.date(from: dateComponents)
        return newDate ?? date
    }
    
    /// Преобразует словарь `[Key: Value]` в отсортированный по `Value`массив кортежей `[(Key, Value)]`
    private func pairs<Key, Value: Comparable>(from dictionary: [Key: Value]) -> [(Key, Value)] {
        return Array(dictionary).sorted(by: {$0.1 > $1.1})
    }
}


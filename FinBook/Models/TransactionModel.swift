//
//  TransactionModel.swift
//  FinBook
//
//  Created by Владимир Рубис on 11.07.2021.
//

import UIKit

struct Transaction {
    var cost: Double
    var description: String
    var category: Category
    var date: Date = Date()
    var note: String
    
//    чтобы понять проходит трата или доход - если доход то "true", а если трата "false"
    var incomeTransaction = false
    
}

enum Category: CaseIterable {
    typealias RawValue = (String, UIImage)
    case products, clothers, car
}

extension Transaction {
    static func getTransactionList() -> [Transaction] {
        
        [Transaction(cost: 150, description: "Шава вЛаваше", category: .products, date: Date(), note: "Вкусно", incomeTransaction: false),
         Transaction(cost: 2500, description: "Замена Шаровой", category: .car, date: Date(), note: "Раз в 30000", incomeTransaction: false),
         Transaction(cost: 333, description: "Футболка Maraton", category: .clothers, date: Date(), note: "На распродаже", incomeTransaction: false)]
        
    }
}

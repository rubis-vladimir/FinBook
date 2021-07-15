//
//  TransactionModel.swift
//  FinBook
//
//  Created by Владимир Рубис on 11.07.2021.
//

import Foundation

struct Transaction {
    var cost: Double
    var label: String
    var category: Category
    var date: Date
    var note: String = ""
    
//    чтобы понять проходит трата или доход - если доход то "true", а если трата "false"
    var incomeTransaction = false
    
    
//    static func getTransaction() -> Transaction {
//        Transaction(cost: 100, label: "Траты", category: .car, data: 22.05.2021)
//    }
}


enum Category: String {
    case products = "Продукты"
    case clothes = "Одежда"
    case house = "Дом"
    case health = "Здоровье"
    case car = "Машина"
    case ticket = "Билеты"
    case travelling = "Путешествия"
    case credits = "Кредиты"
    case study = "Oбучение"
    case family = "Семья"
    case taxes = "Налоги"
    case other = "Другое"
}


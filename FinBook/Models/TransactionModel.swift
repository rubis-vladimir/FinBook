//
//  TransactionModel.swift
//  FinBook
//
//  Created by Владимир Рубис on 11.07.2021.
//

import UIKit

struct Transaction {
    var cost: Double
    var label: String
    var category: Category
    var date: Date = Date()
    var note: String
    
//    чтобы понять проходит трата или доход - если доход то "true", а если трата "false"
    var incomeTransaction = false
}

enum Category {
    typealias RawValue = (String, UIImage)
    case products, clothers, car
}

//extension Transaction {
//    static func getTransactionList() -> [Transaction] {
//        
//    }
//}



enum Category: CaseIterable {
    
    static let none =  (label: "Продукты", image: "plus")
    static let products = (label: "Продукты", image: "plus")
    static let clothes = "Одежда"
    static let house = "Дом"
    static let health = "Здоровье"
    static let car = "Машина"
    static let ticket = "Билеты"
    static let travelling = "Путешествия"
    static let credits = "Кредиты"
    static let study = "Oбучение"
    static let family = "Семья"
    static let taxes = "Налоги"
    static let other = "Другое"
}


//
//  TransactionModel.swift
//  FinBook
//
//  Created by Владимир Рубис on 11.07.2021.
//

import Foundation

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

struct Transaction {
    var cost: Double
    var label: String
    var category: Category
    var note: String
    var data: Data
}

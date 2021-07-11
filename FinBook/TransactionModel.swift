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
}

struct Transaction {
    var cost: Double
    var label: String
    var category: Category
    var note: String
    var data: Data
}

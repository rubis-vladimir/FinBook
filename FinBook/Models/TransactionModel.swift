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





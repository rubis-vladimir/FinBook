//
//  CategoryService.swift
//  FinBook
//
//  Created by Владимир Рубис on 29.08.2021.
//

import UIKit

enum Category {
    typealias RawValue = (String, UIImage)
    case products, clothers, car
}

final class CategoryService {
    static var categoryList:[Category:(String,UIImage)] = {
        
        var categories = [Category:(String,UIImage)] ()
        categories[.products] = ("Продукты", UIImage(systemName: "bag") ?? UIImage())
        categories[.clothers] = ("Одежда", UIImage(systemName: "person") ?? UIImage())
        categories[.car] = ("Машина", UIImage(systemName: "car") ?? UIImage())

        return categories
    }()
    
}

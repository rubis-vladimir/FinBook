//
//  CategoryService.swift
//  FinBook
//
//  Created by Владимир Рубис on 29.08.2021.
//  Changed by Nikita Speransky

import UIKit

//      Вы можете отметить целый класс как конечный или финальный, написав слово final перед ключевым словом class (final class). Любая попытка изменить класс так же приведет к ошибке компиляции.

final class CategoryService {
    
    static var categoryList: [Category: (String, UIImage)] = {
        
        var categories = [Category: (String, UIImage)] ()
        categories[.products] = ("Продукты", UIImage(systemName: "bag") ?? UIImage())
        categories[.clothers] = ("Одежда", UIImage(systemName: "person") ?? UIImage())
        categories[.car] = ("Машина", UIImage(systemName: "car") ?? UIImage())
        
        return categories
    }()
    
}


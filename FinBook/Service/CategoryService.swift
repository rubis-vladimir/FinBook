//
//  CategoryService.swift
//  FinBook
//
//  Created by Владимир Рубис on 29.08.2021.
//  Changed by Nikita Speransky

import UIKit

//      Вы можете отметить целый класс как конечный или финальный, написав слово final перед ключевым словом class (final class). Любая попытка изменить класс так же приведет к ошибке компиляции.

final class CategoryService {
    
    static let spendCategoryList: [(String, UIImage)] = [
        ("Продукты", UIImage(systemName: "cart") ?? UIImage()),
        ("Одежда", UIImage(systemName: "person") ?? UIImage()),
        ("Машина", UIImage(systemName: "car") ?? UIImage()),
        ("Лекарства", UIImage(systemName: "pills") ?? UIImage()),
        ("Путешествия", UIImage(systemName: "airplane") ?? UIImage()),
        ("Налоги", UIImage(systemName: "banknote") ?? UIImage()),
        ("Прочее", UIImage(systemName: "figure.walk") ?? UIImage())
    ]
    
    static let incomeCategoryList: [(String, UIImage)] = [
        ("Зарплата", UIImage(systemName: "person.3") ?? UIImage()),
        ("Подработки", UIImage(systemName: "dollarsign.circle") ?? UIImage()),
        ("Дивиденды", UIImage(systemName: "personalhotspot") ?? UIImage()),
        ("Долги", UIImage(systemName: "creditcard") ?? UIImage()),
        ("Продажа вещей", UIImage(systemName: "hifispeaker.and.homepod") ?? UIImage()),
        ("Прочее", UIImage(systemName: "figure.walk") ?? UIImage())
    ]
        
        
}


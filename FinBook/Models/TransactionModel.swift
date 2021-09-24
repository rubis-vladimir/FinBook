//
//  TransactionModel.swift
//  FinBook
//
//  Created by Владимир Рубис on 11.07.2021.
//  Changed by Nikita Speransky

import UIKit

// MARK: - Модель Тразакций

struct Transaction: Codable {
    var cost: Double
    var description: String
    var category: Category
    var date: Date = Date()
    var note: String?
    var incomeTransaction = false ///    чтобы понять проходит трата или доход - если доход то "true", а если трата "false"
    
//    enum CodingKeys: String, CodingKey {
//        case cost = "cost"
//        case description = "description"
//        case category = "category"
//        case date = "date"
//        case note = "note"
//        case incomeTransaction = "incomeTransaction"
//    }
}


// MARK: - Модель категорий
/*
struct Category: Codable, Hashable {
    var name: String
    var image: UIImage
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
    
    enum CodingKeys: String, CodingKey {
        case name, image
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        
        let data = try values.decode(Data.self, forKey: .image)
        guard let image = UIImage(data: data) else {
            throw DecodingError.dataCorruptedError(forKey: .image, in: values, debugDescription: "Invalid image data")
        }
        self.image = image
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(image.pngData(), forKey: .image)
    }
}
 */

// MARK: - Модель категорий через ENUM

enum Category {
    typealias RawValue = (name: String, image: UIImage)
    case products (String, UIImage)
    case clothers  (String, UIImage)
    case car  (String, UIImage)
}

extension Category: Codable, Hashable {
    
    enum Keys: CodingKey {
        case rawValue
        case associatedValue
    }
    
    enum CodingError: Error {
        case unknownValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        let name = try container.decode(String.self, forKey: .associatedValue)
        //            let image = try container.decode(Data.self, forKey: .associatedValue)
        let data = try container.decode(Data.self, forKey: .associatedValue)
        guard let image = UIImage(data: data) else {
            throw DecodingError.dataCorruptedError(forKey: .associatedValue, in: container, debugDescription: "Invalid image data")
        }
        switch rawValue {
        case 0:
            self = .products(name, image)
        case 1:
            self = .clothers(name, image)
        case 2:
            self = .car(name, image)
        default:
            throw CodingError.unknownValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        switch self {
        case let .products (name, image):
            try container.encode(0, forKey: .rawValue)
            try container.encode(name, forKey: .associatedValue)
            try container.encode(image.pngData(), forKey: .associatedValue)
        case let .clothers(name, image):
            try container.encode(1, forKey: .rawValue)
            try container.encode(name, forKey: .associatedValue)
            try container.encode(image.pngData(), forKey: .associatedValue)
        case let .car(name, image):
            try container.encode(2, forKey: .rawValue)
            try container.encode(name, forKey: .associatedValue)
            try container.encode(image.pngData(), forKey: .associatedValue)
        }
    }
}


struct Icon: Codable {
    var image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
    
    enum CodingKeys: String, CodingKey {
        case image
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let data = try values.decode(Data.self, forKey: .image)
        guard let image = UIImage(data: data) else {
            throw DecodingError.dataCorruptedError(forKey: .image, in: values, debugDescription: "Invalid image data")
        }
        self.image = image
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(image.pngData(), forKey: .image)
    }
}

// MARK: --

/*

enum Category: Codable {
    typealias RawValue = (String, UIImage)
    case products, clothers, car

    enum CodingKeys: CodingKey {
        case products
        case clothers
        case car
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        Category.RawValue = try values.decode(Int.self, forKey: .products)

        let data = try values.decode(Data.self, forKey: .image)
        guard let image = UIImage(data: data) else {
            throw DecodingError.dataCorruptedError(forKey: .image, in: values, debugDescription: "Invalid image data")
        }
                self.image = image
    }

    func encode(to encoder: Encoder) throws {
    }
}

*/

// MARK: --

//extension Transaction {
//    static func getTransactionList() -> [Transaction] {
//
//        [Transaction(cost: 150, description: "Шава вЛаваше", category: .products, date: Date(), note: "Вкусно", incomeTransaction: false),
//         Transaction(cost: 2500, description: "Замена Шаровой", category: .car, date: Date(), note: "Раз в 30000", incomeTransaction: false),
//         Transaction(cost: 333, description: "Футболка Maraton", category: .clothers, date: Date(), note: "На распродаже", incomeTransaction: false)]
//
//    }
//}


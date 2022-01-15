//
//  DateManager.swift
//  FinBook
//
//  Created by Сперанский Никита on 21.12.2021.
//

import Foundation

class DateConvertManager {
    static let shared = DateConvertManager()
    
    private let dateFormatter = DateFormatter()
    
    func convertDateToStr(date: Date?) -> String {
        guard let date2 = date else { return "error while wrapping Date"}
        
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "HH:mm  dd.MMMyyyy"
        let stringDate = dateFormatter.string(from: date2)
        
        return stringDate
    }
    
}

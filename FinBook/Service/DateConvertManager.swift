//
//  DateManager.swift
//  FinBook
//
//  Created by Сперанский Никита on 21.12.2021.
//

import Foundation

class DateConvertManager {
    
    static func convertDateToStr(_ date: Date?) -> String {
        let dateFormatter = DateFormatter()
        
        guard let date2 = date else { return "error while wrapping Date"}
        
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "HH:mm  dd.MMMyy"
        let stringDate = dateFormatter.string(from: date2)
        
        return stringDate
    }
    
}

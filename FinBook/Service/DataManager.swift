//
//  DataManager.swift
//  FinBook
//
//  Created by Владимир Рубис on 12.12.2021.
//

import UIKit

struct DataManager {
    
    static let fileName = "developers"
    static let fileType = "json"
    
    static func getDeveloperDataWithSuccess(success: @escaping ((_ data: Data?) -> Void)) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let filePath = Bundle.main.path(forResource: fileName, ofType: fileType) else {
                success(nil)
                return
            }
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)
                success(data)
            } catch {
                fatalError()
            }
        }
    }
}

//
//  LocaleDataFetcher.swift
//  FinBook
//
//  Created by Владимир Рубис on 17.01.2022.
//

import UIKit

class LocalDataFetcher {
    
    func fetchJSONData<T: Decodable>(from file: String, responce: @escaping (T?) -> Void) {
        guard let url = Bundle.main.url(forResource: file, withExtension: nil) else {
            print("Couldn't find \(file) in bundle.")
            return
        }

        guard let data = try? Data(contentsOf: url) else {
            print("Failed to load \(file) from bundle.")
            return
        }

        let decoder = JSONDecoder()
        guard let decoded = try? decoder.decode(T.self, from: data) else {
            print("Failed to decode \(file) from bundle.")
            return
        }
        responce(decoded)
    }
}

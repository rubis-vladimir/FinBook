//
//  LocaleDataFetcher.swift
//  FinBook
//
//  Created by Владимир Рубис on 17.01.2022.
//

import UIKit

// MARK: Протокол получения данных
protocol DataFetcherProtocol {
    
    /// Получает данные и возвращает значение типа `T`, декодированное из объекта JSON
    ///  - Parameters:
    ///     - from: путь к файлу с данными / url
    ///     - responce: замыкание для захвата данных
    func fetchJSONData<T:Decodable>(from: String,
                                    responce: @escaping (T?) -> Void)
}

// MARK: Класс для получения и декодировки данных из расположенного локально файла
final class LocalDataFetcher: DataFetcherProtocol {
    
    /// Получает данные из объекта JSON из`file`
    /// Декодирует их в значение типа `T`
    func fetchJSONData<T: Decodable>(from file: String,
                                     responce: @escaping (T?) -> Void) {
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

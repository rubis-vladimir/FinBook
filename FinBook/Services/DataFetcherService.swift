//
//  DataFetcherService.swift
//  FinBook
//
//  Created by Владимир Рубис on 20.02.2022.
//

// MARK: Сервис получения данных
final class DataFetcherService {
    
    var dataFetcher: DataFetcherProtocol
    
    init(dataFetcher: DataFetcherProtocol = LocalDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    /// Возвращает массив [Developer], декодированный из локально расположенного файла JSON
    func fetchDevelopers(completion: @escaping ([Developer]?) -> Void) {
        let localUrl = "developers.json"
        dataFetcher.fetchJSONData(from: localUrl, responce: completion)
    }
}

//
//  DataFetcherService.swift
//  FinBook
//
//  Created by Владимир Рубис on 20.02.2022.
//

import Foundation

class DataFetcherService {
    
    var localDataFetcher: LocalDataFetcher
    
    init(localDataFetcher: LocalDataFetcher = LocalDataFetcher()) {
        self.localDataFetcher = localDataFetcher
    }
    
    func fetchDevelopers(completion: @escaping ([Developer]?) -> Void) {
        let localUrl = "developers.json"
        localDataFetcher.fetchJSONData(from: localUrl, responce: completion)
    }
}

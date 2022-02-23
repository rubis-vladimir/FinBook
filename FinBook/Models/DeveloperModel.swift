//
//  DeveloperModel.swift
//  FinBook
//
//  Created by Владимир Рубис on 12.12.2021.
//

import UIKit

struct Developer: Decodable {
    var name: String
    var surname: String
    var photo: String
    var links: Links
    
    struct Links: Decodable {
        var email: String
        var gitHub: String
        var linkedin: String
        var telegram: String
    }
}

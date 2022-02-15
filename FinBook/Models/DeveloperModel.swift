//
//  DeveloperModel.swift
//  FinBook
//
//  Created by Владимир Рубис on 12.12.2021.
//

import UIKit

struct Developer: Decodable, Hashable {
    var name: String
    var surname: String
    var photo: String
    var links: Links
    
    struct Links: Decodable, Hashable {
        var email: String
        var gitHub: String
        var linkedin: String
        var telegram: String
    }
}

//struct Links: Decodable, Hashable {
//    var email: String
//    var gitHub: String
//    var linkedin: String
//    var telegram: String
//}

//struct JSONContainer {
//    let
//}

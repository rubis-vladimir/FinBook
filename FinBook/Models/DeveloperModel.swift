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
    var email: String
    var gitHub: String
    var photo: String
    var linkedin: String
    var telegram: String
}

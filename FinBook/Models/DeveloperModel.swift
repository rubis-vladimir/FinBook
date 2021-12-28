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
    var email: String
    var gitHubLink: String
    var photo: String
    var description: String
}

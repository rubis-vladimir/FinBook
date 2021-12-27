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
    
//    init(name: String, surname: String, email: String, gitHubLink: String, photo: String, description: String) {
//        self.name = name
//        self.surname = surname
//        self.email = email
//        self.gitHubLink = gitHubLink
//        self.photo = photo
//        self.description = description
//    }
}

//extension Developer: Equatable {
    
//    static func == (lhs: RadioStation, rhs: RadioStation) -> Bool {
//        return (lhs.name == rhs.name) && (lhs.streamURL == rhs.streamURL) && (lhs.imageURL == rhs.imageURL) && (lhs.desc == rhs.desc) && (lhs.longDesc == rhs.longDesc)
//    }
//}

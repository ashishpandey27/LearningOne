//
//  UserModel.swift
//  LearningOne
//
//  Created by Ashish Pandey on 14/09/20.
//  Copyright © 2020 Simmy Pandey. All rights reserved.
//

import Foundation

struct UserModal : Codable {
    
    let description : String
    let title : String?
    let id : Int?
    
    enum CodingKeys : String, CodingKey {
        
        case description = "capital"
        case id
        case title = "name"
    }
}

class Hero {
    
    var id : Int
    var name : String?
    var powerRanking : Int
    
    
    init(id: Int, name: String?, powerRanking: Int) {
        self.id = id
        self.name = name
        self.powerRanking = powerRanking
    }

}



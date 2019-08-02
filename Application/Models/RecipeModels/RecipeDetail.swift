//
//  Recipe.swift
//
//
//  Created by David Figueroa on 8/1/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation
import ObjectMapper

struct RecipeDetail: Mappable {
    var id: String?
    var title: String?
    var rating: Int?
    var image: String?
    var instructions: String?
    
    //MARK: - Mappable
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        rating <- map["rating"]
        image <- map["image"]
        instructions <- map["instructions"]
    }
    
}

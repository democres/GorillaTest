//
//  Recipe.swift
//
//
//  Created by David Figueroa on 8/1/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation
import ObjectMapper

struct Recipe: Mappable {
    var id: Int?
    var title: String?
    
    
    //MARK: - Mappable
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
    }
    
}

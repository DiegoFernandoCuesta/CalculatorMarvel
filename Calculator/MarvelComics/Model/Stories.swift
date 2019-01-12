//
//  Stories.swift
//  Calculator
//
//  Created by Diego Fernando Cuesta Arevalo on 1/12/19.
//  Copyright © 2019 Diego Fernando Cuesta Arevalo. All rights reserved.
//

import Foundation
import ObjectMapper

class Stories : Mappable {
    
    var id: String!
    var title : String = ""
    var description : String = ""
    var detailUri : String!
    var image: Image = Image()
    
    init() {}
    func mapping(map: Map) {
        self.id <- map["id"]
        self.description <- map["description"]
        self.title <- map["title"]
        self.detailUri <- map["resourceURI"]
        self.image <- map["thumbnail"]
    }
    required init (map: Map) {}
}

// Clase para mapeo de list del objecto Character
class StoriesList : Mappable{
    var status: String?
    var stories : [Stories]?
    required init(map: Map) {}
    func mapping(map: Map) {
        self.status <- map["status"]
        self.stories <- map["data.results"]
    }
}

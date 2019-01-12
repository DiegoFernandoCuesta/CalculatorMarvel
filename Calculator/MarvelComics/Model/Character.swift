//
//  Character.swift
//  Calculator
//
//  Created by Diego Fernando Cuesta Arevalo on 1/11/19.
//  Copyright © 2019 Diego Fernando Cuesta Arevalo. All rights reserved.
//

import Foundation
import ObjectMapper

class Character : Mappable {
    
    var id: String!
    var name : String = ""
    var description : String = ""
    var detailUri : String!
    var image: Image = Image()
    
    init() {}
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.description <- map["description"]
        self.name <- map["name"]
        self.detailUri <- map["resourceURI"]
        self.image <- map["thumbnail"]
    }
    required init (map: Map) {}
}

// Clase para mapeo de list del objecto Character
class CharacterList : Mappable{
    var status: String?
    var characters : [Character]?
    required init(map: Map) {}
    func mapping(map: Map) {
        self.status <- map["status"]
        self.characters <- map["data.results"]
    }
}

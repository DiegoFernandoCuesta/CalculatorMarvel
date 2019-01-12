//
//  Events.swift
//  Calculator
//
//  Created by Diego Fernando Cuesta Arevalo on 1/11/19.
//  Copyright © 2019 Diego Fernando Cuesta Arevalo. All rights reserved.
//

import Foundation
import ObjectMapper

class Events : Mappable {
    
    var id: String!
    var title : String = ""
    var description : String = ""
    var detailUri : String!
    var creators: [IncrustCreators]!
    var image: Image = Image()
    
    init() {}
    func mapping(map: Map) {
        self.id <- map["id"]
        self.description <- map["description"]
        self.title <- map["title"]
        self.detailUri <- map["resourceURI"]
        self.creators <- map["creators"]
        self.image <- map["thumbnail"]
    }
    required init (map: Map) {}
}

// Clase para mapeo de list del objecto Character
class EventsList : Mappable{
    
    var status: String?
    var events : [Events]?
    required init(map: Map) {}
    func mapping(map: Map) {
        self.status <- map["status"]
        self.events <- map["data.results"]
    }
}

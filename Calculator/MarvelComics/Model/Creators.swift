//
//  Creators.swift
//  Calculator
//
//  Created by Diego Fernando Cuesta Arevalo on 1/11/19.
//  Copyright © 2019 Diego Fernando Cuesta Arevalo. All rights reserved.
//

import Foundation
import ObjectMapper

class Creators : Mappable {
    
    var id: String!
    var fullName : String = ""
    var detailUri: String = ""
    var image: Image = Image()
    
    init() {}
    func mapping(map: Map) {
        self.id <- map["id"]
        self.detailUri <- map["resourceURI"]
        self.fullName <- map["fullName"]
        self.image <- map["thumbnail"]
    }
    required init (map: Map) {}
}


// Clase para mapeo de list del objecto Creators
class CreatorsList : Mappable{
    var status: String?
    var creators : [Creators]?
    required init(map: Map) {}
    func mapping(map: Map) {
        self.status <- map["status"]
        self.creators <- map["data.results"]
    }
}

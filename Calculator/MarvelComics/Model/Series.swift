//
//  Series.swift
//  Calculator
//
//  Created by Diego Fernando Cuesta Arevalo on 1/11/19.
//  Copyright © 2019 Diego Fernando Cuesta Arevalo. All rights reserved.
//

import Foundation
import ObjectMapper

class Series : Mappable {
    
    var id: String!
    var title: String = ""
    var description: String = ""
    var startYear: Int!
    var endYear : Int!
    var rating: String!
    var detailUri: String!
    var image: Image = Image()
    var creators: IncrustCreators!
    
    init(){}
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.description <- map["description"]
        self.title <- map["title"]
        self.rating <- map["rating"]
        self.startYear <- map["startYear"]
        self.endYear <- map["endYear"]
        self.detailUri <- map["resourceURI"]
        self.image <- map["thumbnail"]
        self.creators <- map["creators"]
    }
    required init (map: Map) {}
}

class IncrustCreators: Mappable {
    
    var resourceURI: String!
    var name: String!
    var role: String!

    required init(map: Map) {}
    func mapping(map: Map) {
        self.resourceURI <- map["items.resourceURI"]
        self.name <- map["items.name"]
        self.role <- map["items.role"]
    }
}

// Clase para mapeo de list del objecto Character
class SeriesList : Mappable{
    
    var status: String?
    var series : [Series]?
    
    required init(map: Map) {}
    func mapping(map: Map) {
        self.status <- map["status"]
        self.series <- map["data.results"]
    }
}

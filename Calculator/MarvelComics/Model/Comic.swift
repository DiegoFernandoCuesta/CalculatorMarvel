//
//  Comic.swift
//  Calculator
//
//  Created by Diego Fernando Cuesta Arevalo on 1/11/19.
//  Copyright © 2019 Diego Fernando Cuesta Arevalo. All rights reserved.
//

import Foundation
import ObjectMapper

class Comic : Mappable {
    
    var id: String!
    var title : String = ""
    var description : String = ""
    var detailUri : String!
    var collections: [CollectionComics]!
    var image: Image = Image()
    
    init() {
        title = ""
        description = ""
        detailUri = ""
    }
    func mapping(map: Map) {
        self.id <- map["id"]
        self.description <- map["description"]
        self.title <- map["title"]
        self.detailUri <- map["resourceURI"]
        self.image <- map["thumbnail"]
        self.collections <- map["collectedIssues"]
    }
    required init (map: Map) {}
}

class CollectionComics : Mappable {
    var name: String!
    
    init() {}
    func mapping(map: Map) {
        self.name <- map["name"]
    }
    required init (map: Map) {}
}

// Clase para mapeo de list del objecto Character
class ComicList : Mappable{
    var status: String?
    var comics : [Comic]?
    required init(map: Map) {}
    func mapping(map: Map) {
        self.status <- map["status"]
        self.comics <- map["data.results"]
    }
}

//
//  Image.swift
//  Calculator
//
//  Created by Diego Fernando Cuesta Arevalo on 1/11/19.
//  Copyright © 2019 Diego Fernando Cuesta Arevalo. All rights reserved.
//

import Foundation
import ObjectMapper

enum IconDownloadState{
    case null, loaded, finish
}

class Image: Mappable {

    var urlIcon: String!
    var suffix: String!
    var dot: String = "."
    var iconState: IconDownloadState = .null
    
    init() {}
    func mapping(map: Map) {
        self.urlIcon <- map["path"]
        self.suffix <- map["extension"]
    }
    required init (map: Map) {}
    
    func getImgSquareUrl() -> String {
        if let url = urlIcon {
            return url+Constants.METRIC_SQUARE_IMG+dot+suffix
        }
        return Constants.IMAGE_NOT_FOUND
    }
    
    func getImgLandScapeUrl() -> String {
        if let url = urlIcon {
            return url+Constants.METRIC_SQUARE_IMG+dot+suffix
        }
        return Constants.IMAGE_NOT_FOUND
    }
    
}


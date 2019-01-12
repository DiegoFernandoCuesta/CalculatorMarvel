//
//  MarvelDetailViewModel.swift
//  Calculator
//
//  Created by Diego Fernando Cuesta Arevalo on 1/12/19.
//  Copyright © 2019 Diego Fernando Cuesta Arevalo. All rights reserved.
//

import Foundation

class MarvelDetailViewModel {

    var tittle: String!
    var description: String!
    var imageLandscape: Image!
    var updateDetail: (() -> Void)?

    func setGenericDetail( tittle: String, description: String, image: Image){
        self.tittle = tittle
        self.description = description
        self.imageLandscape = image
    }
    
    func getLandscapeUrlImage() -> URL {
        return URL(string: imageLandscape.getImgLandScapeUrl())!
    }
    
}

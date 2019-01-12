//
//  Constants.swift
//  Calculator
//
//  Created by Diego Fernando Cuesta Arevalo on 1/3/19.
//  Copyright © 2019 Diego Fernando Cuesta Arevalo. All rights reserved.
//

import Foundation

class Constants {
    
    static let BASE_URL = "http://gateway.marvel.com/v1/public/%@"
    static let API_KEY = "apikey=fcdc0d88c77212285a0bbe0a6ab1774a"
    static let HASH = "&hash=6a7d32b6c1ed394f4c2d06985466d084"
    static let TS = "&ts=1"
    static var URL_SERVICES: String = BASE_URL + API_KEY + HASH + TS + OFFSET
    
    static let CHARACTERS: String  = "characters?"
    static let COMICS: String  = "comics?"
    static let CREATORS: String  = "creators?"
    static let EVENTS: String  = "events?"
    static let SERIES: String  = "series?"
    static let STORIES: String  = "stories?"
    
    static let OFFSET = "&offset=%@"
    
    static let METRIC_SQUARE_IMG = "/standard_amazing"
    static let METRIC_LANDSCAPE = "landscape_incredible"
    static let IMAGE_NOT_FOUND = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/standard_amazing.jpg"
    
   //Segues
    static let MarvelTableSegue = "MarvelTableSegue"
    static let MarvelDetailSegue = "MarvelDetailSegue"

}

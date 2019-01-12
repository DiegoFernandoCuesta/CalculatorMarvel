//
//  Services.swift
//  Calculator
//
//  Created by Diego Fernando Cuesta Arevalo on 1/11/19.
//  Copyright © 2019 Diego Fernando Cuesta Arevalo. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import ObjectMapper
import AlamofireObjectMapper

class Service {
    
    static func getCharacters( offset:String, success:@escaping ([Character]) -> Void, failure:@escaping (Error) -> Void ) {
        let url = Constants.URL_SERVICES.format(Constants.CHARACTERS,offset)
        Alamofire.request(url).responseObject {(response: DataResponse<CharacterList>) in
            if response.result.isSuccess {
                let lCharacters = response.result.value!
                if lCharacters.characters?.count == nil {
                    success( [Character]() )
                }else{
                    success((lCharacters.characters)!)
                }
            }
            if response.result.isFailure {
                let error : Error = response.result.error!
                failure(error)
            }
        }
    }
    
    static func getComics( offset:String, success:@escaping ([Comic]) -> Void, failure:@escaping (Error) -> Void ) {
        let url = Constants.URL_SERVICES.format(Constants.COMICS,offset)
        Alamofire.request(url).responseObject {(response: DataResponse<ComicList>) in
            if response.result.isSuccess {
                let lComics = response.result.value!
                if lComics.comics?.count == nil {
                    success( [Comic]() )
                }else{
                    success((lComics.comics)!)
                }
            }
            if response.result.isFailure {
                let error : Error = response.result.error!
                failure(error)
            }
        }
    }
    
    static func getCreators( offset:String, success:@escaping ([Creators]) -> Void, failure:@escaping (Error) -> Void ) {
        let url = Constants.URL_SERVICES.format(Constants.CREATORS,offset)
        Alamofire.request(url).responseObject {(response: DataResponse<CreatorsList>) in
            if response.result.isSuccess {
                let lCreators = response.result.value!
                if lCreators.creators?.count == nil {
                    success( [Creators]() )
                }else{
                    success((lCreators.creators)!)
                }
            }
            if response.result.isFailure {
                let error : Error = response.result.error!
                failure(error)
            }
        }
    }
    
    static func getSeries( offset:String, success:@escaping ([Series]) -> Void, failure:@escaping (Error) -> Void ) {
        let url = Constants.URL_SERVICES.format(Constants.SERIES,offset)
        Alamofire.request(url).responseObject {(response: DataResponse<SeriesList>) in
            if response.result.isSuccess {
                let lSeries = response.result.value!
                if lSeries.series?.count == nil {
                    success( [Series]() )
                }else{
                    success((lSeries.series)!)
                }
            }
            if response.result.isFailure {
                let error : Error = response.result.error!
                failure(error)
            }
        }
    }
    
    static func getEvents( offset:String, success:@escaping ([Events]) -> Void, failure:@escaping (Error) -> Void ) {
        let url = Constants.URL_SERVICES.format(Constants.EVENTS,offset)
        Alamofire.request(url).responseObject {(response: DataResponse<EventsList>) in
            if response.result.isSuccess {
                let lEvents = response.result.value!
                if lEvents.events?.count == nil {
                    success( [Events]() )
                }else{
                    success((lEvents.events)!)
                }
            }
            if response.result.isFailure {
                let error : Error = response.result.error!
                failure(error)
            }
        }
    }
    
    static func getStories( offset:String, success:@escaping ([Stories]) -> Void, failure:@escaping (Error) -> Void ) {
        let url = Constants.URL_SERVICES.format(Constants.STORIES,offset)
        Alamofire.request(url).responseObject {(response: DataResponse<StoriesList>) in
            if response.result.isSuccess {
                let lStories = response.result.value!
                if lStories.stories?.count == nil {
                    success( [Stories]() )
                }else{
                    success((lStories.stories)!)
                }
            }
            if response.result.isFailure {
                let error : Error = response.result.error!
                failure(error)
            }
        }
    }
}

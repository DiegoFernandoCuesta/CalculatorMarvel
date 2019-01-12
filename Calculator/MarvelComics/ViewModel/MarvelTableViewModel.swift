//
//  MarvelTableViewModel.swift
//  Calculator
//
//  Created by Diego Fernando Cuesta Arevalo on 1/11/19.
//  Copyright © 2019 Diego Fernando Cuesta Arevalo. All rights reserved.
//

import Foundation
import UIKit

class MarvelTableViewModel {
    
    var offset: Int = 0
    private let inicialOffset = 0
    private let plusOffset = 20
    
    var isLoadMoreData: Bool = false
    
    var updateData: (() -> Void)?
    var addUpdateData: (() -> Void)?

    var typeData: TypeList = TypeList.Comic
    
    var dataSource: [Any] = [] {
        didSet { self.updateData?() }
    }
    
    func setOffset(){
        offset += plusOffset
    }
    
    func resetOffset(){
        offset = inicialOffset
    }
    
    func setLoadMoreData(_ load: Bool){
        isLoadMoreData = load
    }

    
    func addData(){
        isLoadMoreData = true
        setOffset()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loadData()
            self.addUpdateData?()
        }
    }
    
    func loadData(){
        switch typeData {
        case .Character:
            getCharacters(offset: offset)
        case .Comic:
            getComics(offset: offset)
        case .Creators:
            getCreators(offset: offset)
        case .Series:
            getSeries(offset: offset)
        case .Events:
            getEvents(offset: offset)
        case .Stories:
            getStories(offset: offset)
        }
    }

    func getCharacters(offset: Int){
        typeData = TypeList.Character
        Service.getCharacters(offset: String(offset), success: { (characters) in
            self.dataSource.append(contentsOf: characters)
            self.setLoadMoreData(false)
        }) { (Error) in }
    }
    
    func getComics(offset: Int){
        typeData = TypeList.Comic
        Service.getComics(offset: String(offset), success: { (comics) in
            self.dataSource.append(contentsOf: comics)
            self.setLoadMoreData(false)
        }) { (Error) in }
    }
    
    func getCreators(offset: Int){
        typeData = TypeList.Creators
        Service.getCreators(offset: String(offset), success: { (creators) in
            self.dataSource.append(contentsOf: creators)
            self.setLoadMoreData(false)
        }) { (Error) in }
    }
    
    func getSeries(offset: Int){
        typeData = TypeList.Series
        Service.getSeries(offset: String(offset), success: { (series) in
            self.dataSource.append(contentsOf: series)
            self.setLoadMoreData(false)
        }) { (Error) in }
    }
    
    func getEvents(offset: Int){
        typeData = TypeList.Events
        Service.getEvents(offset: String(offset), success: { (events) in
            self.dataSource.append(contentsOf: events)
            self.setLoadMoreData(false)
        }) { (Error) in }
    }
    
    func getStories(offset: Int){
        typeData = TypeList.Stories
        Service.getStories(offset: String(offset), success: { (stories) in
            self.dataSource.append(contentsOf: stories)
            self.setLoadMoreData(false)
        }) { (Error) in }
    }
    
    // functions cells
    
    func getNameCell(index: Int) -> String {
        switch typeData {
        case .Character:
            guard let character = dataSource[index] as? Character else { return "" }
            return character.name
        case .Comic:
            guard let comic = dataSource[index] as? Comic else { return "" }
            return comic.title
        case .Creators:
            guard let creator = dataSource[index] as? Creators else { return "" }
            return creator.fullName
        case .Series:
            guard let serie = dataSource[index] as? Series else { return "" }
            return serie.title
        case .Events:
            guard let event = dataSource[index] as? Events else { return "" }
            return event.title
        case .Stories:
            guard let storie = dataSource[index] as? Stories else { return "" }
            return storie.title
        }
    }
    
    func getDescriptionCell(index: Int) -> String {
        switch typeData {
        case .Character:
            guard let character = dataSource[index] as? Character else { return "" }
            return character.description
        case .Comic:
            guard let comic = dataSource[index] as? Comic else { return "" }
            return comic.description
        case .Series:
            guard let serie = dataSource[index] as? Series else { return "" }
            return serie.description
        case .Events:
            guard let event = dataSource[index] as? Events else { return "" }
            return event.description
        case .Stories:
            guard let storie = dataSource[index] as? Stories else { return "" }
            return storie.description
        case .Creators:
            return ""
        }
    }
    
    func getImage(index: Int) -> Image? {
        switch typeData {
        case .Character:
            guard let character = dataSource[index] as? Character else { return nil }
            return character.image
        case .Comic:
            guard let comic = dataSource[index] as? Comic else { return nil }
            return comic.image
        case .Creators:
            guard let creator = dataSource[index] as? Creators else { return nil }
            return creator.image
        case .Series:
            guard let series = dataSource[index] as? Series else { return nil }
            return series.image
        case .Events:
            guard let event = dataSource[index] as? Events else { return nil }
            return event.image
        case .Stories:
            guard let storie = dataSource[index] as? Stories else { return nil }
            return storie.image
        }
    }
    
}

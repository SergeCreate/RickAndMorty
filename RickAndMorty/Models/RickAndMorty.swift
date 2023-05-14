//
//  RickAndMorty.swift
//  RickAndMorty
//
//  Created by Сергей Захаров on 06.05.2023.
//

import Foundation

struct CharacterResponse: Decodable {
    let results: [Character]
}

struct Character: Decodable {
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let location: Location
    let image: String
    
    var description: String {
        """
        Name: \(name)
        Status: \(status)
        Species: \(species)
        Type: \(type)
        Gender: \(gender)
        Location: \(location.name)
        """
    }
    
    init?(json: [String: Any]) {
        guard let name = json["name"] as? String,
              let status = json["status"] as? String,
              let species = json["species"] as? String,
              let type = json["type"] as? String,
              let gender = json["gender"] as? String,
              let locationDict = json["location"] as? [String: Any],
              let location = Location(json: locationDict),
              let image = json["image"] as? String else {
            return nil
        }
        
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.location = location
        self.image = image
    }
}

struct Location: Decodable {
    let name: String
    
    init?(json: [String: Any]) {
        guard let name = json["name"] as? String else {
            return nil
        }
        
        self.name = name
    }
}

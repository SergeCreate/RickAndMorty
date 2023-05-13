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
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    var description: String {
        """
    Name: \(name)
    Status: \(status)
    Species: \(species)
    Gender: \(gender)
    Location: \(location.name)
    """
    }
}

struct Location: Decodable {
    let name: String
}


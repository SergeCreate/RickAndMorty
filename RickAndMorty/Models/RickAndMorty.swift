//
//  RickAndMorty.swift
//  RickAndMorty
//
//  Created by Сергей Захаров on 06.05.2023.
//

import Foundation

struct CharacterResponse: Codable {
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
    let episode: [String]
    let url: String
    let created: String
}


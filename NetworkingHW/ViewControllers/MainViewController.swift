//
//  MainViewController.swift
//  NetworkingHW
//
//  Created by Сергей Захаров on 06.05.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRickAndMorty()
    }
    
    private func fetchRickAndMorty() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let characters = try decoder.decode(CharacterResponse.self, from: data)
                for character in characters.results {
                    print("Name: \(character.name)")
                    print("Status: \(character.status)")
                    print("Species: \(character.species)")
                    print("Type: \(character.type)")
                    print("Gender: \(character.gender)")
                    print("Image: \(character.image)")
                    print("Episodes: \(character.episode)")
                    print("Created: \(character.created)\n")
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

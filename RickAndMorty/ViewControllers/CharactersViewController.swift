//
//  CharactersTableViewController.swift
//  RickAndMorty
//
//  Created by Сергей Захаров on 06.05.2023.
//

import UIKit

final class CharactersViewController: UITableViewController {
    
    private var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        
        let urlString = "https://rickandmortyapi.com/api/character"
        NetworkManager.shared.fetch(CharacterResponse.self, from: urlString) { [weak self] result in
            switch result {
            case .success(let response):
                self?.characters = response.results
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        guard let cell = cell as? CharacterCell else { return
            UITableViewCell() }
        let character = characters[indexPath.row]
        cell.configure(with: character)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


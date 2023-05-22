//
//  CharactersViewController.swift
//  RickAndMorty
//
//  Created by Сергей Захаров on 06.05.2023.
//

import UIKit
// избавиться от фреймворка
final class CharactersViewController: UITableViewController {
    
    private var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barStyle = .black
        if let noteworthyBoldFont = UIFont(name: "Noteworthy-Bold", size: 28) {
            self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.08704253286, green: 0.6926050782, blue: 0.5707834363, alpha: 1),
                NSAttributedString.Key.font: noteworthyBoldFont
            ]
        }
        
        let urlString = "https://rickandmortyapi.com/api/character"
        
        AF.request(urlString).validate().responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                guard let json = value as? [String: Any],
                      let results = json["results"] as? [[String: Any]] else { return }
                self?.characters = results.compactMap { Character(json: $0) }
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
        guard let cell = cell as? CharacterCell else { return UITableViewCell() }
        let character = characters[indexPath.row]
        cell.configure(with: character)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailsVC = storyboard.instantiateViewController(withIdentifier: "showDetail") as? CharacterDetailsViewController else { return }
        detailsVC.character = character
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

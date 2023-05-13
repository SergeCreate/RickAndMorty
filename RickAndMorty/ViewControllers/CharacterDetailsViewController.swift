//
//  CharacterDetailsViewController.swift
//  RickAndMorty
//
//  Created by Сергей Захаров on 12.05.2023.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var characterImageView: UIImageView! {
        didSet {
            characterImageView.layer.cornerRadius = characterImageView.frame.width / 2
        }
    }

    var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let character = character {
            descriptionLabel.text = character.description
        }
        
        guard let character = character else {
            return
        }
        
        title = character.name
        
        NetworkManager.shared.fetchImage(from: character.image) { result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    self.characterImageView.image = UIImage(data: imageData)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        NetworkManager.shared.fetch(Character.self, from: character.url) { result in
            switch result {
            case .success(let character):
                DispatchQueue.main.async {
                    self.descriptionLabel.text = character.description
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

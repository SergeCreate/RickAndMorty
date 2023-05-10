//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Сергей Захаров on 10.05.2023.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    @IBOutlet var characterImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    private let netWorkManager = NetworkManager.shared
    
    func configure(with character: Character) {
        nameLabel.text = character.name

        netWorkManager.fetchImage(from: character.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
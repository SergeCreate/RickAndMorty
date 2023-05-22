//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Сергей Захаров on 10.05.2023.
//

import UIKit
//
final class CharacterCell: UITableViewCell {
    
    @IBOutlet var characterImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    private let netWorkManager = NetworkManager.shared
    
    override func layoutSubviews() {
        super.layoutSubviews()
        characterImage.layer.cornerRadius = min(characterImage.bounds.width, characterImage.bounds.height) / 2
    }
    
    func configure(with character: Character) {
        nameLabel.text = character.name
        
        let loadingImageView = UIImageView(image: UIImage(named: "loading"))
        loadingImageView.contentMode = .scaleAspectFit
        loadingImageView.frame.size = CGSize(width: 200, height: 200)
        loadingImageView.center = characterImage.center
        characterImage.addSubview(loadingImageView)
        
        netWorkManager.fetchImage(from: character.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImage.image = UIImage(data: imageData)
                loadingImageView.removeFromSuperview()
            case .failure(let error):
                print(error)
            }
        }
    }
}

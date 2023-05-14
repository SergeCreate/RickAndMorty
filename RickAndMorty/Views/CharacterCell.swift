//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Сергей Захаров on 10.05.2023.
//

import UIKit
import Alamofire

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
        
        AF.request(character.image).validate().responseData { [weak self] response in
            switch response.result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                self?.characterImage.image = image
                loadingImageView.removeFromSuperview()
            case .failure(let error):
                print(error)
            }
        }
    }
}

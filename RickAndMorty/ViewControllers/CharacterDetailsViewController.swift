//
//  CharacterDetailsViewController.swift
//  RickAndMorty
//
//  Created by Сергей Захаров on 12.05.2023.
//

import UIKit

final class CharacterDetailsViewController: UIViewController {
    
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
            title = character.name
            descriptionLabel.text = character.description
            
            AF.download(character.image).responseData { [weak self] response in
                switch response.result {
                case .success(let imageData):
                    DispatchQueue.main.async {
                        self?.characterImageView.image = UIImage(data: imageData)
                    }
                case .failure(let error):
                    print("Error downloading character image: \(error)")
                }
            }
        }
    }
}

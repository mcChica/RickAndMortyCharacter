//
//  CharacterCellView.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 28/2/23.
//

import Foundation
import UIKit
import Kingfisher

class CharacterCellView: UITableViewCell {
    
    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let characterName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 32, weight: .bold, width: .condensed)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init has not been implemented")
    }
    
    func setupViews(){
       addSubview(characterImageView)
        addSubview(characterName)
        
        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            characterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            characterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            characterImageView.widthAnchor.constraint(equalToConstant: 200),

            characterName.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor,constant: 50),
            characterName.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -12),
            characterName.topAnchor.constraint(equalTo: characterImageView.topAnchor, constant: 100)
        
        ])
    }
    
    func configure(model: CharacterViewModel) {
        characterImageView.kf.setImage(with: model.imageURL)
        characterName.text = model.name
    }
    
}

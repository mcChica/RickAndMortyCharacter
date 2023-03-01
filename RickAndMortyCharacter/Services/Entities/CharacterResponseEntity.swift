//
//  RMResponseEntity.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 27/2/23.
//

import Foundation

struct CharacterResponseEntity: Decodable {
    let results:[CharacterModel]
    
}

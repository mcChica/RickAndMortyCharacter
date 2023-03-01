//
//  mapperCharacterViewModel.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 28/2/23.
//

import Foundation

struct MapperCharacterViewModel {
    func map(entity: CharacterModel) -> CharacterViewModel {
        CharacterViewModel(name: entity.name, imageURL: URL(string: entity.image))
    }
}

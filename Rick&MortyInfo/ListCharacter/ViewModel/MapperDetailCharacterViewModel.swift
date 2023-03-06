//
//  MapperDetailCharacterViewModel.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 28/2/23.
//

import Foundation

struct MapperDetailCharacterViewModel {
    func map(entity: DetailCharacterEntity) -> DetailCharacterViewModel {
        .init(id: entity.id, name: entity.name, status: entity.status, species: entity.species, gender: entity.gender, image: URL(string: entity.image))
        
    }
    
}

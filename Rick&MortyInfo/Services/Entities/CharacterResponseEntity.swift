//
//  RMResponseEntity.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 27/2/23.
//

import Foundation

struct CharacterResponseEntity: Decodable {
    let info: PageInfo
    let results:[CharacterModel]
    
    struct PageInfo: Decodable {
           let count: Int
           let pages: Int
           let next: String?
           let prev: String?
       }
 
    
}

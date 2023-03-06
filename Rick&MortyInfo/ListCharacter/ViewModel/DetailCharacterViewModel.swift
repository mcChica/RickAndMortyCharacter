//
//  DetailCharacterViewModel.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 28/2/23.
//

import Foundation

struct DetailCharacterViewModel: Equatable ,Identifiable {
    
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: URL?
    
}

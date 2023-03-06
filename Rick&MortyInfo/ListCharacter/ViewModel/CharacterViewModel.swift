//
//  ViewModel.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 28/2/23.
//

import Foundation

struct CharacterViewModel: Equatable ,Identifiable { 
    let id: Int
    let name: String
    let image: URL?
}

//
//  DetailInteractor.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 28/2/23.
//

import Foundation

protocol DetailInteractable: AnyObject {
    func getDetailCharacter(withId id: String) async -> DetailCharacterEntity
}


class DetailInteractor {
    func getDetailCharacter(withId id: String) async -> DetailCharacterEntity {
        let url = URL(string: "https://rickandmortyapi.com/api/character/\(id)")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try! jsonDecoder.decode(DetailCharacterEntity.self, from: data)
    }
    
}

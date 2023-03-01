//
//  ListCharacterInteractor.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 27/2/23.
//

import Foundation

protocol ListCharacterInteractorImp: AnyObject {
    func getListofCharacter() async -> CharacterResponseEntity
}

class ListCharacterInteractor: ListCharacterInteractorImp {
    let apiClient = NetworkManager()
    
    /*
    func fetchCharacters()  {
        apiClient.request(Endpoint.getCharacter) { (result: Result<CharacterResponseEntity, Error>) in
            switch result {
            case .success(let response):
                print(response)
               
                
              
              //  self.presenter.presentCharacters(response.results)
            case .failure(let error):
                // Manejamos el error
                print(error.localizedDescription)
            }
        }
    }*/
    
    func getListofCharacter() async -> CharacterResponseEntity {
        
        let url = URL(string: "https://rickandmortyapi.com/api/character" )!
        let (data , _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(CharacterResponseEntity.self , from: data)
    }
}

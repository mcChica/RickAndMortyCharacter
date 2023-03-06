//
//  ListCharacterInteractor.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 27/2/23.
//

import Foundation

protocol ListCharacterInteractorImp: AnyObject {
    func getListofCharacter(url: String ) async throws -> CharacterResponseEntity
    func getListofCharacterFilter(status: String) async throws -> CharacterResponseEntity
}

class ListCharacterInteractor: ListCharacterInteractorImp {
    let apiClient = NetworkManager()
    
    
    func getListofCharacter(url: String = Endpoint.getCharacter) async throws -> CharacterResponseEntity {
        try await withUnsafeThrowingContinuation { continuation in
            apiClient.request(url) { (result: Result<CharacterResponseEntity, Error>) in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    
    func getListofCharacterFilter(status: String) async throws -> CharacterResponseEntity {
        try await withUnsafeThrowingContinuation { continuation in
            apiClient.requestFiltersStatus(status) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error as AppError):
                        switch error {
                        case .notFound:
                            fatalError("Error: \(error.localizedDescription)")
                        default:
                            fatalError("Error: \(error.localizedDescription)")
                        }
                    case .failure(let error):
                        fatalError("Error: \(error.localizedDescription)")
                    }
            }
        }
    }

}

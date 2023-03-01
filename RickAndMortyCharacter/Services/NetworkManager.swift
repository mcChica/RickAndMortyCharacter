//
//  NetworkManager.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 28/2/23.
//

import Foundation

class NetworkManager {
    func request<T: Decodable>(_ url: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? APIError.unknown))
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(APIError.parseError))
            }
        }.resume()
    }
    
    enum APIError: Error {
        case invalidURL
        case unknown
        case parseError
    }
}

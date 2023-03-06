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
            completion(.failure(AppError.apiError(.invalidURL)))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(AppError.apiError(.unknown)))
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(AppError.apiError(.parseError)))
            }
        }.resume()
    }
    
    func request<T: Decodable>(url: String) async -> Result<T, Error> {
            guard let url = URL(string: url) else {
                return .failure(AppError.apiError(.invalidURL))
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let result = try JSONDecoder().decode(T.self, from: data)
                return .success(result)
            } catch {
                return .failure(AppError.apiError(.unknown))
            }
        }
    
    func requestFiltersStatus(_ status: String, completion: @escaping (Result<CharacterResponseEntity, Error>) -> Void) {
        guard let url = URL(string: Endpoint.getFiltersStatus + status) else {
            completion(.failure(AppError.apiError(.invalidURL)))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(AppError.apiError(.unknown)))
                return
            }
            do {
                let result = try JSONDecoder().decode(CharacterResponseEntity.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(AppError.apiError(.parseError)))
            }
        }.resume()
    }
}

//
//  AppError.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 2/3/23.
//

import Foundation

enum AppError: Error {
    case apiError(APIError)
    case networkError(NetworkError)
    case decodingError(DecodingError)
    case unknownError(Error)
    case notFound
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .apiError(let apiError):
            return apiError.localizedDescription
        case .networkError(let networkError):
            return networkError.localizedDescription
        case .decodingError(let decodingError):
            return decodingError.localizedDescription
        case .unknownError(let error):
            return error.localizedDescription
        case .notFound:
            return "Resource not found"
        }
    }
}

enum APIError: Error {
    case invalidURL
    case unknown
    case parseError
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .unknown:
            return "Unknown error occurred"
        case .parseError:
            return "Error parsing data"
        }
    }
}

enum NetworkError: Error {
    case noInternetConnection
    case requestTimeout
    case serverError
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "No internet connection"
        case .requestTimeout:
            return "Request timed out"
        case .serverError:
            return "Server error occurred"
        case .unknown:
            return "Unknown error occurred"
        }
    }
}

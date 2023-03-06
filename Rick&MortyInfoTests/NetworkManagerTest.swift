//
//  NetworkManagerTest.swift
//  Rick&MortyInfoTests
//
//  Created by Carlos Chica on 1/3/23.
//

import XCTest
@testable import Rick_MortyInfo

final class NetworkManagerTest: XCTestCase {

    func testRequestWithValidURLReturnsExpectedData() throws {
        // Given
        let url = "https://rickandmortyapi.com/api/character/1"
        let expectation = XCTestExpectation(description: "Request should return expected data")
        let networkManager = NetworkManager()

        // When
        networkManager.request(url) { (result: Result<CharacterModel, Error>) in
            // Then
            switch result {
            case .success(let character):
                XCTAssertEqual(character.id, 1)
                XCTAssertEqual(character.name, "Rick Sanchez")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Request failed with error: \(error.localizedDescription)")
            }
        }

        wait(for: [expectation], timeout: 10.0)
    }
    
    func testRequestWithValidURLReturnsData() throws {
        // Given
        let url = "https://rickandmortyapi.com/api/character/1"
        let expectation = XCTestExpectation(description: "Request should return data")
        let networkManager = NetworkManager()

        // When
        networkManager.request(url) { (result: Result<CharacterModel, Error>) in
            // Then
            switch result {
            case .success(let character):
                XCTAssertEqual(character.id, 1)
                XCTAssertEqual(character.name, "Rick Sanchez")
                XCTAssertEqual(character.status, "Alive")
                XCTAssertEqual(character.species, "Human")
                XCTAssertEqual(character.gender, "Male")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Request should not have failed with error: \(error.localizedDescription)")
            }
        }

        wait(for: [expectation], timeout: 10.0)
    }

    
    func testRequestWithValidURLReturnsSuccess() throws {
        let expectation = XCTestExpectation(description: "Returns success with valid URL")
        let networkManager = NetworkManager()
        let url = Endpoint.getCharacter
        
        networkManager.request(url) { (result: Result<CharacterResponseEntity, Error>) in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Request failed with error: \(error.localizedDescription)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testRequestFiltersStatusWithInvalidURLReturnsInvalidURLError() throws {
        // given
        let networkManager = NetworkManager()
        let invalidURL = "not a valid url"
        let expectation = self.expectation(description: "Request completion")
        
        // when
        networkManager.requestFiltersStatus(invalidURL) { result in
            // then
            switch result {
            case .success(_):
                XCTFail("Expected failure with invalid URL")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Invalid URL")
            }
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 5, handler: nil)
    }

    func testRequestReturnsCharacters() throws {
        let expectation = self.expectation(description: "Characters received")
        let networkManager = NetworkManager()
        let url = Endpoint.getCharacter
        networkManager.request(url) { (result: Result<CharacterResponseEntity, Error>) in
            switch result {
            case .success(let response):
                XCTAssertGreaterThan(response.results.count, 0)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error should not occur: \(error.localizedDescription)")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }



}


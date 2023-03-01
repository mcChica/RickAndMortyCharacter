//
//  DetailViewTests.swift
//  RickAndMortyCharacterUITests
//
//  Created by Carlos Chica on 28/2/23.
//

import Foundation

import XCTest
@testable import RickAndMortyCharacter

class DetailViewTests: XCTestCase {
    
    func testUpdateUI() {
        // Given
        let presenter = MockDetailPresenter()
        let detailView = DetailView(presenter: presenter)
        let detailViewModel = DetailCharacterViewModel(name: "Rick", status: "Rick Sanchez", species: "Alive", gender: "Human", image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"))
        
        // When
        detailView.updateUI(detailViewModel: detailViewModel)
        
        // Then
        XCTAssertEqual(detailView.detailName.text, detailViewModel.name)
        XCTAssertEqual(detailView.status.text, detailViewModel.status)
        XCTAssertEqual(detailView.species.text, detailViewModel.species)
        XCTAssertEqual(detailView.gender.text, detailViewModel.gender)
    }
    
    func testViewDidLoad() {
        // Given
        let presenter = MockDetailPresenter()
        let detailView = DetailView(presenter: presenter)
        
        // When
        detailView.viewDidLoad()
        
        // Then
        XCTAssertNotNil(detailView.characterImageView)
        XCTAssertNotNil(detailView.detailName)
        XCTAssertNotNil(detailView.status)
        XCTAssertNotNil(detailView.species)
        XCTAssertNotNil(detailView.gender)
        XCTAssertTrue(detailView.view.subviews.contains(detailView.characterImageView))
        XCTAssertTrue(detailView.view.subviews.contains(detailView.detailName))
        XCTAssertTrue(detailView.view.subviews.contains(detailView.status))
        XCTAssertTrue(detailView.view.subviews.contains(detailView.species))
        XCTAssertTrue(detailView.view.subviews.contains(detailView.gender))
    }
    
}

class MockDetailPresenter: DetailPresentable {
    var ui: RickAndMortyCharacter.DetailPresenterUI?
    
    var characterId: String = "1"
    
    
    func onViewAppear() {
        // Nothing to do here
    }
    
}


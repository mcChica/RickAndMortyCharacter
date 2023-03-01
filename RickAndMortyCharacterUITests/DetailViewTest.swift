//
//  DetailViewTest.swift
//  RickAndMortyCharacterUITests
//
//  Created by Carlos Chica on 28/2/23.
//

import Foundation

import XCTest
@testable import RickAndMortyCharacter

class DetailViewTests: XCTestCase {

    var detailView: DetailView!
    var presenter: MockDetailPresenter!

    override func setUp() {
        super.setUp()
        presenter = MockDetailPresenter()
        detailView = DetailView(presenter: presenter)
    }

    override func tearDown() {
        presenter = nil
        detailView = nil
        super.tearDown()
    }

    func testUpdateUI() {
        let viewModel = DetailCharacterViewModel(name: !, status: "Rick Sanchez", species: "Alive", gender: "Human", image: "Male")
        detailView.updateUI(detailViewModel: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"))
        XCTAssertEqual(detailView.detailName.text, "Rick Sanchez")
        XCTAssertEqual(detailView.status.text, "Alive")
        XCTAssertEqual(detailView.species.text, "Human")
        XCTAssertEqual(detailView.gender.text, "Male")
    }
}

class MockDetailPresenter: DetailPresentable {
    var ui: RickAndMortyCharacter.DetailPresenterUI?
    
    var characterId: String = ""
    
    func onViewAppear() {
        // No hace nada
    }
}

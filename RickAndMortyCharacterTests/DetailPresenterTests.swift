//
//  DetailPresenterTests.swift
//  RickAndMortyCharacterTests
//
//  Created by Carlos Chica on 28/2/23.
//

import Foundation

@testable import RickAndMortyCharacter
import XCTest

class DetailPresenterTests: XCTestCase {
    
    class MockDetailPresenterUI: DetailPresenterUI {
        var didUpdateUI = false
        var detailViewModel: DetailCharacterViewModel?
        
        func updateUI(detailViewModel: DetailCharacterViewModel) {
            self.didUpdateUI = true
            self.detailViewModel = detailViewModel
        }
    }
    
    class MockDetailInteractor: DetailInteractable {
        func getDetailCharacter(withId characterId: String) async -> DetailCharacterEntity {
            return DetailCharacterEntity(name: "1", status: "Alive", species: "Human", gender: "Male", image: "")
        }
    }
    
    
    var sut: DetailPresenter!
    var mockUI: MockDetailPresenterUI!
    
    
    override func tearDown() {
        mockUI = nil
        sut = nil
        super.tearDown()
    }
    
    func testOnViewAppear() {
        sut.onViewAppear()
        
        XCTAssertTrue(mockUI.didUpdateUI)
        XCTAssertNotNil(mockUI.detailViewModel)
    }
    
}

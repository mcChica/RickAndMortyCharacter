//
//  DetailPresenter.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 27/2/23.
//

import Foundation
import SwiftUI

import Foundation

protocol DetailPresenterUI: AnyObject {
    func updateUI(detailViewModel: DetailCharacterViewModel)
}

protocol DetailPresentable: AnyObject {
    var ui: DetailPresenterUI? { get }
    var characterId: String { get }
    func onViewAppear()
}

class DetailPresenter: DetailPresentable, DetailPresenterUI, ObservableObject {

    weak var ui: DetailPresenterUI?
    let characterId: String
    private let interactor: DetailInteractable
    private let mapper: MapperDetailCharacterViewModel
    
    @Published var detailViewModel: DetailCharacterViewModel?
    
    init(characterId: String, interactor: DetailInteractable, mapper: MapperDetailCharacterViewModel) {
        self.characterId = characterId
        self.interactor = interactor
        self.mapper = mapper
    }
    
    func onViewAppear() {
        Task {
            let model = await interactor.getDetailCharacter(withId: characterId)
            let detailViewModel = mapper.map(entity: model)
            await MainActor.run {
                self.detailViewModel = detailViewModel
                self.ui?.updateUI(detailViewModel: detailViewModel)
            }
        }
    }
    
    func updateUI(detailViewModel: DetailCharacterViewModel) {
        self.detailViewModel = detailViewModel
    }
    
}

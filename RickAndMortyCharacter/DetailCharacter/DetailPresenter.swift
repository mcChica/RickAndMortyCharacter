//
//  DetailPresenter.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 27/2/23.
//

import Foundation

protocol DetailPresenterUI: AnyObject{
    func updateUI(detailViewModel: DetailCharacterViewModel)
}

protocol DetailPresentable: AnyObject {
    var ui: DetailPresenterUI? { get }
    var characterId: String { get }
    func onViewAppear()
    
}


class DetailPresenter: DetailPresentable {

    weak var ui: DetailPresenterUI?
    
    let characterId: String
    private let interactor: DetailInteractable
    private let mapper: MapperDetailCharacterViewModel
    
    init(characterId: String, interactor: DetailInteractable, mapper: MapperDetailCharacterViewModel) {
        self.characterId = characterId
        self.interactor = interactor
        self.mapper = mapper
    }
    
    func onViewAppear() {
        Task {
            let model = await interactor.getDetailCharacter(withId: characterId)
            let detailViewModel = mapper.map(entity: model)
            print(detailViewModel)
            await MainActor.run {
                self.ui?.updateUI(detailViewModel:detailViewModel)
                print(detailViewModel)
            }
        }
        
    }
    
}

//
//  ListCharacterPresenter.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 27/2/23.
//

import Foundation

protocol ListOfCharacterPresentable: AnyObject {
    var ui: ListOfDetailUI? { get }
    var characterViewModel: [CharacterViewModel] { get }
    func onViewAppear()
    func onTapCell(atIndex: Int)
}

protocol ListOfDetailUI: AnyObject{
    func update(detailViewModel: [CharacterViewModel])
}


class ListCharacterPresenter: ListOfCharacterPresentable{
   
    
    weak var ui: ListOfDetailUI?
    
    
     let listCharacterInteractor: ListCharacterInteractor
    private let mapperCharacter: MapperCharacterViewModel
    private let router: ListCharacterRouting
    
    var characterViewModel: [CharacterViewModel] = []
    var models: [CharacterModel] = []
    
    init(listCharacterInteractor: ListCharacterInteractor,mapper: MapperCharacterViewModel = MapperCharacterViewModel(), router: ListCharacterRouting) {
        self.listCharacterInteractor = listCharacterInteractor
        self.mapperCharacter = mapper
        self.router = router
    }
    
    
    func onViewAppear() {
        Task{
            models = await listCharacterInteractor.getListofCharacter().results
            characterViewModel = models.map(mapperCharacter.map(entity:))
            ui?.update(detailViewModel: characterViewModel)
        }
    }
    
    func onTapCell(atIndex: Int) {
        let characterId = models[atIndex].id
        router.showDetailCharacter(withCharacterId: characterId.description)
    }
    
}


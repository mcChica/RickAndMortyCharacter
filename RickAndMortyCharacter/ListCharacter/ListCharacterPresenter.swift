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
    func loadMoreCharactersIfNeeded(forRowAt indexPath: IndexPath)
    func filterCharacters(status: String)
}

protocol ListOfDetailUI: AnyObject{
    func update(detailViewModel: [CharacterViewModel])
}


class ListCharacterPresenter: ListOfCharacterPresentable {

    var nextPage: String? = nil
    weak var ui: ListOfDetailUI?
   
    let listCharacterInteractor: ListCharacterInteractor
    let mapperCharacter: MapperCharacterViewModel
    private let router: ListCharacterRouting
    
    var characterViewModel: [CharacterViewModel] = []
    var models: [CharacterModel] = []
    
    init(listCharacterInteractor: ListCharacterInteractor,mapper: MapperCharacterViewModel = MapperCharacterViewModel(), router: ListCharacterRouting) {
        self.listCharacterInteractor = listCharacterInteractor
        self.mapperCharacter = mapper
        self.router = router
    }
    
    
    func onViewAppear() {
        Task {
            do {
                let response = try await listCharacterInteractor.getListofCharacter()
                models = response.results
                characterViewModel = models.map(mapperCharacter.map(entity:))
                nextPage = response.info.next
                await MainActor.run {
                    ui?.update(detailViewModel: characterViewModel)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func onTapCell(atIndex: Int) {
        let characterId = models[atIndex].id
        router.showDetailCharacter(withCharacterId: characterId.description)
    }
    func loadMoreCharactersIfNeeded(forRowAt indexPath: IndexPath) {
        let lastRowIndex = models.count - 1
        if indexPath.row == lastRowIndex, let next = nextPage {
            Task {
                do {
                    let response = try await listCharacterInteractor.getListofCharacter(url: next)
                    models.append(contentsOf: response.results)
                    let newViewModel = response.results.map(mapperCharacter.map(entity:))
                    characterViewModel.append(contentsOf: newViewModel)
                    nextPage = response.info.next
                    await MainActor.run {
                        ui?.update(detailViewModel: characterViewModel)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func filterCharacters(status: String) {
        Task {
            do {
                let response = try await listCharacterInteractor.getListofCharacterFilter(status: status)
                models = response.results
                characterViewModel = models.map(mapperCharacter.map(entity:))
                nextPage = response.info.next
                await MainActor.run {
                    ui?.update(detailViewModel: characterViewModel)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
}


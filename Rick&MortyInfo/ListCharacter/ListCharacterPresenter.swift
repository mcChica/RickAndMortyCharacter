//
//  ListCharacterPresenter.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 27/2/23.
//
import Foundation
import SwiftUI

class ListCharacterPresenter: ObservableObject {
    
    private let listCharacterInteractor: ListCharacterInteractor
    private let mapperCharacter: MapperCharacterViewModel
    
    @Published var characterViewModel: [CharacterViewModel] = []
    
    private var nextPage: String? = nil
    var isLoadingMore = false
    
    init(listCharacterInteractor: ListCharacterInteractor, mapper: MapperCharacterViewModel = MapperCharacterViewModel()) {
        self.listCharacterInteractor = listCharacterInteractor
        self.mapperCharacter = mapper
    }
    
    func onViewAppear() {
        Task {
            do {
                let response = try await listCharacterInteractor.getListofCharacter()
                DispatchQueue.main.async {
                    self.characterViewModel = response.results.map(self.mapperCharacter.map(entity:))
                    self.nextPage = response.info.next
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func loadMoreCharactersIfNeeded(for characterViewModel: CharacterViewModel) {
        guard !isLoadingMore else { return }
          guard (characterViewModel.id == self.characterViewModel.last?.id) != nil else { return }
          guard let nextPage = self.nextPage else { return }
        
        isLoadingMore = true
        
        Task {
            do {
                let response = try await listCharacterInteractor.getListofCharacter(url: nextPage)
                let newCharacterViewModels = response.results.map(self.mapperCharacter.map(entity:))
                
                DispatchQueue.main.async {
                    self.characterViewModel.append(contentsOf: newCharacterViewModels)
                    self.nextPage = response.info.next
                    self.isLoadingMore = false
                }
                
            } catch {
                print(error.localizedDescription)
                self.isLoadingMore = false
            }
        }
    }
    
    func filterCharacters(status: String) {
        Task {
            do {
             
                let response = try await listCharacterInteractor.getListofCharacterFilter(status: status)
                DispatchQueue.main.async {
                    self.characterViewModel = response.results.map(self.mapperCharacter.map(entity:))
                    self.nextPage = response.info.next
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

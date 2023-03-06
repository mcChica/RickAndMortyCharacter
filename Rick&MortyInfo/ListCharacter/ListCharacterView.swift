//
//  ListCharacterView.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 27/2/23.
//


import SwiftUI

struct ListCharacterView: View {
    
    @StateObject private var presenter: ListCharacterPresenter
    
    @State private var isModalVisible = false
    @State private var selectedCharacter: CharacterViewModel?
    @State private var selectedFilter: String = ""
    @State private var filterSelection = "all"
    private let filterOptions = ["all", "alive", "dead", "unknown"]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("CHARACTERS")
                    .font(Font.custom("Helvetica Neue Bold", size: 36))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10)
                
                Picker("Filter", selection: $filterSelection) {
                    ForEach(filterOptions, id: \.self) { option in
                        Text(option.capitalized).tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                
                List(presenter.characterViewModel, id: \.id) { character in
                    Button {
                        selectedCharacter = character
                        isModalVisible = true
                    } label: {
                        CharacterCellView(character: character)
                            .padding(.vertical, 5)
                    }
                   
                    
                    if character == presenter.characterViewModel.last {
                        // Última celda de la lista
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 1)
                            .onAppear {
                                presenter.loadMoreCharactersIfNeeded(for: character)
                            }
                    }
                    
                }
              
                
                
                .onAppear {
                    presenter.onViewAppear()
                }
                
                .sheet(item: $selectedCharacter) { character in
                    let detailPresenter = DetailPresenter(
                        characterId: String(character.id),
                        interactor: DetailInteractor(networkManager: NetworkManager()),
                        mapper: MapperDetailCharacterViewModel()
                    )
                    DetailView(presenter: detailPresenter)
                        .onAppear {
                            detailPresenter.onViewAppear()
                        }
                }
            }
            .background(
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Color(red: 27/255, green: 19/255, blue: 45/255),
                            Color(red: 61/255, green: 115/255, blue: 139/255)
                        ]
                    ),
                    startPoint: .topLeading,
                    endPoint: .center
                )
            )
            .onChange(of: filterSelection) { newSelection in
                if newSelection == "all" {
                    presenter.onViewAppear()
                } else {
                    presenter.filterCharacters(status: newSelection)
                }
            }
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    init(presenter: ListCharacterPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }
}



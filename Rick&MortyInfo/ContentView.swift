//
//  ContentView.swift
//  Rick&MortyInfo
//
//  Created by Carlos Chica on 2/3/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
    ListCharacterView(presenter: ListCharacterPresenter(listCharacterInteractor: ListCharacterInteractor()))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

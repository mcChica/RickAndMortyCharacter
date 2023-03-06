//
//  CharacterCellView.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 28/2/23.
//
import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct CharacterCellView: View {
    let character: CharacterViewModel
    
    var body: some View {
        HStack(spacing: 10) {
            WebImage(url: character.image)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 7)
            
            Text(character.name)
                .font(.custom("HelveticaNeue-Bold", size: 20))
                .lineLimit(3)
        }
    }
}



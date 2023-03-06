//
//  DetailView.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 28/2/23.
//


import SwiftUI
import SDWebImageSwiftUI


struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 160/255, green: 197/255, blue: 226/255), Color(red: 2/255, green: 74/255, blue: 109/255)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                if let imageUrl = presenter.detailViewModel?.image {
                    
                    WebImage(url: imageUrl)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .padding(.top)
                }
                
                if let name = presenter.detailViewModel?.name {
                    Text(name)
                        .font(.system(size: 28, weight: .bold, design: .default))
                        .underline()
                }
                
                if let status = presenter.detailViewModel?.status {
                    let iconColor = status == "Alive" ? Color.green : (status == "Dead" ? Color.red : Color.yellow)
                    
                    HStack {
                        Image(systemName: status == "Alive" ? "checkmark.circle.fill" : (status == "Dead" ? "xmark.circle.fill" : "questionmark.circle.fill"))
                            .foregroundColor(iconColor)
                        
                        Text("Status: \(status)")
                            .font(.headline)
                    }
                }
                
                if let species = presenter.detailViewModel?.species {
                    HStack {
                        Image(systemName: "globe")
                            .foregroundColor(.orange)
                        
                        Text("Species: \(species)")
                            .font(.headline)
                    }
                }
                
                if let gender = presenter.detailViewModel?.gender {
                    let genderIcon = gender == "Male" ? "person.fill" : (gender == "person.fill.female" ? "venus" : "person.crop.circle.badge.questionmark")
                    
                    HStack {
                        Image(systemName: genderIcon)
                            .foregroundColor(.blue)
                        
                        Text("Gender: \(gender)")
                            .font(.headline)
                    }
                }
                
                Spacer()
                
                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.headline)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color.white)
                .foregroundColor(.black)
                .clipShape(Capsule())
            }
            .padding()
            .foregroundColor(.white)
        }
        .onAppear {
            presenter.onViewAppear()
        }
    }
}

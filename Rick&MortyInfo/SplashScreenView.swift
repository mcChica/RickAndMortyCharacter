//
//  SplashScreenView.swift
//  Rick&MortyInfo
//
//  Created by Carlos Chica on 3/3/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var  size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Image("splashScreenImage")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                
                Image("text_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400)
                    .opacity(opacity)
                    .padding(.top, -350)
                    .onAppear {
                        withAnimation(.easeIn(duration: 0.5)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

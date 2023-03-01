//
//  SceneDelegate.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 27/2/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var listCharacterRouter = ListCharacterRouter()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
       
        window = UIWindow(windowScene: windowScene)
        listCharacterRouter.showListCharacter(window: window)
    }
}


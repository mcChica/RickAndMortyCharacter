//
//  ListChatarterRouter.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 27/2/23.
//

import UIKit
import RickMortySwiftApi

protocol ListCharacterRouting: AnyObject{
    var detailRouter: DetailRouting? { get }
    var listOfCharacterView: ListCharacterView? { get }

    func showListCharacter(window: UIWindow?)
    func showDetailCharacter(withCharacterId id: String)
}


class ListCharacterRouter: ListCharacterRouting {
 
    var detailRouter: DetailRouting?
    var listOfCharacterView: ListCharacterView?
    
    func showListCharacter(window: UIWindow?){
        self.detailRouter = DetailRouter()
        let interactor = ListCharacterInteractor()
        let presenter = ListCharacterPresenter(listCharacterInteractor: interactor, router: self)
        
        listOfCharacterView = ListCharacterView(presenter: presenter)
        presenter.ui = listOfCharacterView
        
        window?.rootViewController = listOfCharacterView
        window?.makeKeyAndVisible()
    }
    
    func showDetailCharacter(withCharacterId id: String) {
        guard let fromViewController = listOfCharacterView else { return }
        detailRouter?.showDetail(fromViewViewController: fromViewController, withDetailId: id)
    }
 
}


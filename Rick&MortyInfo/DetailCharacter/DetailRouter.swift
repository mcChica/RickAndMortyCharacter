//
//  DetailRouter.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 27/2/23.
//

import Foundation
import UIKit

protocol DetailRouting: AnyObject {
    func showDetail(fromViewViewController: UIViewController, withDetailId id: String)
}

class DetailRouter: DetailRouting {
    func showDetail(fromViewViewController: UIViewController, withDetailId id: String) {
        let network = NetworkManager()
        let interactor = DetailInteractor(networkManager: network)
        let presenter = DetailPresenter(characterId: id, interactor: interactor , mapper: MapperDetailCharacterViewModel())
        
        let view = DetailView(presenter: presenter)
        presenter.ui = view
        fromViewViewController.present(view, animated: true)
    }
}

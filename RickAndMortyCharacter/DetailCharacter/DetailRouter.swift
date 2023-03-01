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
        let interactor = DetailInteractor()
        let presenter = DetailPresenter(characterId: id, interactor: interactor as! DetailInteractable , mapper: MapperDetailCharacterViewModel())
        
        let view = DetailView(presenter: presenter)
        presenter.ui = view
        fromViewViewController.present(view, animated: true)
    }
}

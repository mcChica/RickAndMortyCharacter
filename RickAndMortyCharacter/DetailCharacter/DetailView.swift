//
//  DetailView.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 28/2/23.
//

import Foundation
import UIKit
import Kingfisher

class DetailView: UIViewController {
    private let presenter: DetailPresentable
    
    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let detailName: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 32,weight: .bold,width: .condensed)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let status: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 32,weight: .bold,width: .condensed)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let species: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 32,weight: .bold,width: .condensed)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let gender: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 32,weight: .bold,width: .condensed)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   
    
    init(presenter: DetailPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.onViewAppear()
        view.backgroundColor = .white
    }
    
    func setupView() {
        view.addSubview(characterImageView)
        view.addSubview(detailName)
        view.addSubview(status)
        view.addSubview(species)
        view.addSubview(gender)

        NSLayoutConstraint.activate([
               characterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
               characterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               characterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
               characterImageView.heightAnchor.constraint(equalToConstant: 200)
           ])
           
           // Agregar restricciones para el detailName
           NSLayoutConstraint.activate([
               detailName.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 16),
               detailName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               detailName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
           ])
           
           // Agregar restricciones para el status
           NSLayoutConstraint.activate([
               status.topAnchor.constraint(equalTo: detailName.bottomAnchor, constant: 16),
               status.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               status.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
           ])
           
           // Agregar restricciones para el species
           NSLayoutConstraint.activate([
               species.topAnchor.constraint(equalTo: status.bottomAnchor, constant: 16),
               species.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               species.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
           ])
           
           // Agregar restricciones para el gender
           NSLayoutConstraint.activate([
               gender.topAnchor.constraint(equalTo: species.bottomAnchor, constant: 16),
               gender.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               gender.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
           ])

    }
 
}
extension DetailView: DetailPresenterUI {
    func updateUI(detailViewModel: DetailCharacterViewModel) {
        characterImageView.kf.setImage(with: detailViewModel.image)
        detailName.text = "Name: " + detailViewModel.name
        status.text = "Status: " + detailViewModel.status
        species.text = "Species: " + detailViewModel.species
        gender.text = "Gender: " + detailViewModel.gender
    }
    
    
    
}

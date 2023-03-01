//
//  ListCharacterView.swift
//  RickAndMortyCharacter
//
//  Created by Carlos Chica on 27/2/23.
//

import UIKit

class ListCharacterView: UIViewController {

    private var characterTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CharacterCellView.self, forCellReuseIdentifier: "CharacterCellView")
        return tableView
    }()


    let presenter: ListCharacterPresenter
 
    
    init(presenter: ListCharacterPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter.onViewAppear()
    }
    
    private func setupTableView(){
        view.addSubview(characterTableView)
        NSLayoutConstraint.activate([
            characterTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            characterTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            characterTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            characterTableView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        characterTableView.dataSource = self
        characterTableView.delegate = self
    }

}


extension ListCharacterView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.characterViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = characterTableView.dequeueReusableCell(withIdentifier: "CharacterCellView", for: indexPath) as! CharacterCellView
        cell.backgroundColor = .red
        let model = presenter.characterViewModel[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
}


extension ListCharacterView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onTapCell(atIndex: indexPath.row)
    }
    
}


extension ListCharacterView: ListOfDetailUI {
    func update(detailViewModel character: [CharacterViewModel]) {
        DispatchQueue.main.async {
            self.characterTableView.reloadData()
        }
    }
}

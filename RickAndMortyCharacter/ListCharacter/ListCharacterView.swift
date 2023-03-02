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
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = 70
        tableView.register(CharacterCellView.self, forCellReuseIdentifier: "CharacterCellView")
        return tableView
    }()

    private let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Filter", for: .normal)
        button.addTarget(self, action: #selector(didTapFilterButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
 
    private let filterMenu = UIAlertController(title: "Filter by state", message: nil, preferredStyle: .actionSheet)

    @objc func didTapFilterButton() {
        present(filterMenu, animated: true, completion: nil)
    }

    private func setupFilterMenu() {
        let statuses = ["alive", "dead", "unknown"]
        for status in statuses {
            let action = UIAlertAction(title: status, style: .default) { [weak self] _ in
                self?.presenter.filterCharacters(status: status)
            }
            filterMenu.addAction(action)
        }
    }

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
        setupFilterMenu()
        presenter.onViewAppear()
    }
    
    private func setupTableView(){
        view.addSubview(characterTableView)
        view.addSubview(filterButton)
            NSLayoutConstraint.activate([
                filterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ])
        
        NSLayoutConstraint.activate([
            characterTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            characterTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            characterTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            characterTableView.topAnchor.constraint(equalTo: view.topAnchor),            
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
        let model = presenter.characterViewModel[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex, let next = presenter.nextPage {
            Task {
                do {
                    let response = try await presenter.listCharacterInteractor.getListofCharacter(url: next)
                    presenter.models.append(contentsOf: response.results)
                    presenter.characterViewModel = presenter.models.map(presenter.mapperCharacter.map(entity:))
                    presenter.nextPage = response.info.next
                    await MainActor.run {
                        presenter.ui?.update(detailViewModel: presenter.characterViewModel)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
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

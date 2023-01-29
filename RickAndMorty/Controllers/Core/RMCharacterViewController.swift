//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 29.12.2022.
//

import UIKit

/// Controller to show and search for Characters
final class RMCharacterViewController: UIViewController {

    // MARK: - Private Properties
    private let characterListView = RMCharacterListView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        view.addSubview(characterListView)
        addCharacterViewConstraints()
        
        characterListView.delegate = self
    }
    
    // MARK: - Private Methods
    private func addCharacterViewConstraints() {
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - RMCharacterListViewDelegate
extension RMCharacterViewController: RMCharacterListViewDelegate {
    
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

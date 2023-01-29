//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 29.12.2022.
//

import UIKit

/// Controller to show and search for Locations
final class RMLocationViewController: UIViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Locations"
        view.backgroundColor = .systemBackground
        
        addSearchButton()        
    }

    // MARK: - Private Methods
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        
    }
}

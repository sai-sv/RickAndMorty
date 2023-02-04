//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 29.12.2022.
//

import UIKit

/// Controller to show and search for Locations
final class RMLocationViewController: UIViewController {

    // MARK: - Private Properties
    private let locationListView = RMLocationListView()
    private var viewModel = RMLocationListViewViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Locations"
        view.backgroundColor = .systemBackground
        
        addSearchButton()
        view.addSubview(locationListView)
        addConstraints()
        
        viewModel.delegate = self
        viewModel.fetchLocations()
    }

    // MARK: - Private Methods
    private func addConstraints() {
        NSLayoutConstraint.activate([
            locationListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            locationListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            locationListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        
    }
}

// MARK: - ViewModel Delegate
extension RMLocationViewController: RMLocationListViewViewModelDelegate {
    
    func didLoadInitialLocations() {
        locationListView.configure(with: viewModel)
    }
}

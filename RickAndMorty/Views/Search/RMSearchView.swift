//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 06.02.2023.
//

import UIKit

final class RMSearchView: UIView {

    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private let noResultsView: RMNoSearchResultsView
    
    private let viewModel: RMSearchViewViewModel
    
    // MARK: - Init
    init(viewModel: RMSearchViewViewModel) {
        self.noResultsView = RMNoSearchResultsView(viewModel: .init())
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(noResultsView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    private func addConstraints() {
        NSLayoutConstraint.activate([
            noResultsView.widthAnchor.constraint(equalToConstant: 159),
            noResultsView.heightAnchor.constraint(equalToConstant: 150),
            noResultsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultsView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }    
}

// MARK: - CollectionView Delegate & DataSource
extension RMSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

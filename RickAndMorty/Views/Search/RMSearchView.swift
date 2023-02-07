//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 06.02.2023.
//

import UIKit

protocol RMSearchViewDelegate: AnyObject {
    func rmSearchView(_ searchView: RMSearchView,
                      didSelectOption option: RMSearchInputViewViewModel.DynamicOption)
}

final class RMSearchView: UIView {

    // MARK: - Public Properties
    weak var delegate: RMSearchViewDelegate?
    
    // MARK: - Private Properties
    private let searchInputView = RMSearchInputView()
    private let noResultsView = RMNoSearchResultsView()
    
    private let viewModel: RMSearchViewViewModel
    
    // MARK: - Init
    init(viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(searchInputView)
        addSubview(noResultsView)
        addConstraints()
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func showKeyboard() {
        searchInputView.showKeyboard()
    }
    
    // MARK: - Private Methods
    private func configure() {
        let searchInputViewViewModel = RMSearchInputViewViewModel(type: viewModel.config.type)
        searchInputView.configure(with: searchInputViewViewModel)
        searchInputView.delegate = self
        
        let noSearchResultsViewModel = RMNoSearchResultsViewViewModel()
        noResultsView.configure(with: noSearchResultsViewModel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchInputView.heightAnchor.constraint(equalToConstant: viewModel.config.type == .episode ? 55 : 110),
            searchInputView.topAnchor.constraint(equalTo: topAnchor),
            searchInputView.leftAnchor.constraint(equalTo: leftAnchor),
            searchInputView.rightAnchor.constraint(equalTo: rightAnchor),
            
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

// MARK: - SearchInputView Delegate
extension RMSearchView: RMSearchInputViewDelegate {
    
    func rmSearchInputView(_ searchInputView: RMSearchInputView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
        delegate?.rmSearchView(self, didSelectOption: option)
    }
}

//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 08.01.2023.
//

import Foundation
import UIKit

protocol RMCharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didSelectCharacter(_ character: RMCharacter)
}

final class RMCharacterListViewViewModel: NSObject {

    // MARK: - Public Properties
    weak var delegate: RMCharacterListViewViewModelDelegate?
    
    var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    // MARK: - Private Properties
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = RMCharacterCollectionViewCellViewModel(characterName: character.name,
                                                                       characterStatusText: character.status,
                                                                       characterImageUrl: URL(string: character.image))
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var apiInfo: RMGetAllCharactersResponse.Info?
    
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
    
    // MARK: - Public Methods
    func fetchCharacters() {
        let request = RMRequest(endpoint: .character)
        
        RMService.shared.execute(request, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                print(response)
                self.characters = response.results
                self.apiInfo = response.info
                DispatchQueue.main.async {
                    self.delegate?.didLoadInitialCharacters()
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchAdditionalCharacters() {
        
    }
}

// MARK: - Collection View
extension RMCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIndentifier, for: indexPath) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
}

// MARK: - Scroll View
extension RMCharacterListViewViewModel: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator else { return }
    }
}

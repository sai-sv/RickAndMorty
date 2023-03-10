//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 08.01.2023.
//

import UIKit

protocol RMCharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didLoadMoreCharacters(with newIndexPath: [IndexPath])
    func didSelectCharacter(_ character: RMCharacter)
}

final class RMCharacterListViewViewModel: NSObject {
    
    // MARK: - Public Properties
    weak var delegate: RMCharacterListViewViewModelDelegate?
    
    // MARK: - Private Properties
    private var apiInfo: RMGetAllCharactersResponse.Info?
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = RMCharacterCollectionViewCellViewModel(characterName: character.name,
                                                                       characterStatusText: character.status,
                                                                       characterImageUrl: URL(string: character.image))
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    private var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
    private var isLoadingMoreCharacters: Bool = false
    
    // MARK: - Public Methods
    func fetchCharacters() {
        RMService.shared.execute(.characterListRequest, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.apiInfo = response.info
                self.characters = response.results
                DispatchQueue.main.async {
                    self.delegate?.didLoadInitialCharacters()
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Private Methods
    private func fetchAdditionalCharacters(url: URL) {
        guard !isLoadingMoreCharacters else { return }
        isLoadingMoreCharacters = true
        
        guard let request = RMRequest(url: url) else { return }
        
        RMService.shared.execute(request, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                let currentCount = self.characters.count
                let additionalCount = response.results.count
                let totalCount = currentCount + additionalCount
                let startIndex = totalCount - additionalCount
                let indexPathsToAdd: [IndexPath] = Array(startIndex..<(startIndex + additionalCount)).compactMap {
                    IndexPath(row: $0, section: 0)
                }
                
                self.apiInfo = response.info
                self.characters.append(contentsOf: response.results)
                
                DispatchQueue.main.async {
                    self.delegate?.didLoadMoreCharacters(with: indexPathsToAdd)
                    self.isLoadingMoreCharacters = false
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.isLoadingMoreCharacters = false
            }
        }
    }
}

// MARK: - Collection View
extension RMCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
                                                            for: indexPath) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    // item size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.5)
    }
    
    // select
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
    
    // footer view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter else {
            fatalError("Unsupported")
        }
        guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
                                                                               for: indexPath) as? RMFooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        footerView.startAnimating()
        return footerView
    }
    
    // footer size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        let size = CGSize(width: collectionView.frame.width, height: 100)
        return size
    }
}

// MARK: - Scroll View
extension RMCharacterListViewViewModel: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator, !isLoadingMoreCharacters, !cellViewModels.isEmpty,
              let next = apiInfo?.next, let url = URL(string: next) else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] timer in
            let frameHeight = scrollView.frame.size.height
            let contentOffset = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            
            if contentOffset >= (contentHeight - frameHeight - 120) {
                self?.fetchAdditionalCharacters(url: url)
            }
            timer.invalidate()
        }
    }
}

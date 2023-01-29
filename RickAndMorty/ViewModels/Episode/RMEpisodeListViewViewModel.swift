//
//  RMEpisodeListViewViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 28.01.2023.
//

import UIKit

protocol RMEpisodeListViewViewModelDelegate: AnyObject {
    func didLoadInitialEpisodes()
    func didLoadMoreEpisodes(with newIndexPath: [IndexPath])
    func didSelectEpisode(_ episode: RMEpisode)
}

final class RMEpisodeListViewViewModel: NSObject {
    
    // MARK: - Public Properties
    weak var delegate: RMEpisodeListViewViewModelDelegate?
    
    // MARK: - Private Properties
    private let borderColors: [UIColor] = [
        .systemMint,
        .systemBlue,
        .systemPink,
        .systemOrange,
        .systemRed,
        .systemGreen,
        .systemYellow,
        .systemPurple,
        .systemCyan
    ]
    private var apiInfo: RMGetAllEpisodesResponse.Info?
    private var episodes: [RMEpisode] = [] {
        didSet {
            for episode in episodes {
                let viewModel = RMCharacterEpisodeCollectionViewCellViewModel(episodeUrl: URL(string: episode.url),
                                                                              borderColor: borderColors.randomElement() ?? .systemBlue)
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    private var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    private var cellViewModels: [RMCharacterEpisodeCollectionViewCellViewModel] = []
    private var isLoadingMoreCharacters: Bool = false
    
    // MARK: - Public Methods
    func fetchEpisodes() {
        RMService.shared.execute(.listEpisodesRequests, expecting: RMGetAllEpisodesResponse.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.apiInfo = response.info
                self.episodes = response.results
                DispatchQueue.main.async {
                    self.delegate?.didLoadInitialEpisodes()
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Private Methods
    private func fetchAdditionalEpisodes(url: URL) {
        guard !isLoadingMoreCharacters else { return }
        isLoadingMoreCharacters = true
        
        guard let request = RMRequest(url: url) else { return }
        
        RMService.shared.execute(request, expecting: RMGetAllEpisodesResponse.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                let currentCount = self.episodes.count
                let additionalCount = response.results.count
                let totalCount = currentCount + additionalCount
                let startIndex = totalCount - additionalCount
                let indexPathsToAdd: [IndexPath] = Array(startIndex..<(startIndex + additionalCount)).compactMap {
                    IndexPath(row: $0, section: 0)
                }
                
                self.apiInfo = response.info
                self.episodes.append(contentsOf: response.results)
                
                DispatchQueue.main.async {
                    self.delegate?.didLoadMoreEpisodes(with: indexPathsToAdd)
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
extension RMEpisodeListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier,
                                                            for: indexPath) as? RMCharacterEpisodeCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    // item size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 20)
        return CGSize(width: width, height: 100)
    }
    
    // select
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let episode = episodes[indexPath.row]
        delegate?.didSelectEpisode(episode)
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
extension RMEpisodeListViewViewModel: UIScrollViewDelegate {
    
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
                self?.fetchAdditionalEpisodes(url: url)
            }
            timer.invalidate()
        }
    }
    
}

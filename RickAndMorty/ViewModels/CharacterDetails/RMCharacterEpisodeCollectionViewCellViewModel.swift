//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 24.01.2023.
//

import Foundation

protocol RMEpisodeDataRenderProtocol {
    var name: String { get }
    var air_date: String { get }
    var episode: String { get }
}

final class RMCharacterEpisodeCollectionViewCellViewModel {
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private var episodeUrl: URL?
    private var episode: RMEpisode? {
        didSet {
            guard let episode = episode else { return }
            dataBlock?(episode)
        }
    }
    private var dataBlock: ((RMEpisodeDataRenderProtocol) -> Void)?
    private var isFetching: Bool = false
        
    // MARK: - Init
    init(episodeUrl: URL?) {
        self.episodeUrl = episodeUrl
    }
    
    // MARK: - Public Methods
    func registerBlock(block: @escaping (RMEpisodeDataRenderProtocol) -> Void) {
        dataBlock = block
    }
    
    func fetchEpisode() {
        guard !isFetching else {
            guard let block = dataBlock, let model = episode else { return }
            block(model)
            return
        }
        
        guard let url = episodeUrl, let request = RMRequest(url: url) else {
            return
        }
        
        isFetching = true
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let episode):
                DispatchQueue.main.async {
                    self?.episode = episode
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
}

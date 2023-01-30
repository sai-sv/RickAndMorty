//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 28.01.2023.
//

import UIKit

protocol RMEpisodeDetailViewViewModelDelegate: AnyObject {
    func didFetchEpisodeDetails()
}

final class RMEpisodeDetailViewViewModel {

    // MARK: - Public Properties
    weak var delegate: RMEpisodeDetailViewViewModelDelegate?
    
    // MARK: - Private Properties
    private let endpointUrl: URL?
    private var dataTuple: (RMEpisode, [RMCharacter])? {
        didSet {
            self.delegate?.didFetchEpisodeDetails()
        }
    }
    
    // MARK: - Init
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl        
    }
    
    // MARK: - Public Methods
    func fetchEpisodeData() {
        guard let url = endpointUrl, let request = RMRequest(url: url) else { return }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let episode):
                self?.fetchRelatedCharacters(episode: episode)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Private Methods
    private func fetchRelatedCharacters(episode: RMEpisode) {
        let requests: [RMRequest] = episode.characters.compactMap({ URL(string: $0)})
            .compactMap { RMRequest(url: $0) }
        
        let group = DispatchGroup()
        var characters: [RMCharacter] = []
        for request in requests {
            group.enter()
            RMService.shared.execute(request, expecting: RMCharacter.self) { result in
                defer { group.leave() }
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        group.notify(queue: .main) {
            self.dataTuple = (episode, characters)
        }
    }
}

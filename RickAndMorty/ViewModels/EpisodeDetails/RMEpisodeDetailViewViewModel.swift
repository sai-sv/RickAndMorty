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
    enum SectionType {
        case information(viewModels: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModels: [RMCharacterCollectionViewCellViewModel])
    }
    private(set) var sections: [SectionType] = []
    weak var delegate: RMEpisodeDetailViewViewModelDelegate?
    
    // MARK: - Private Properties
    private let endpointUrl: URL?
    private var dataTuple: (episode: RMEpisode, characters: [RMCharacter])? {
        didSet {
            self.createSections()
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
    
    func character(at index: Int) -> RMCharacter? {
        guard let dataTuple = dataTuple else {
            return nil
        }
        return dataTuple.characters[index]
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
            self.dataTuple = (episode: episode, characters: characters)
        }
    }
    
    private func createSections() {
        guard let dataTuple = self.dataTuple else { return }
        let episode = dataTuple.episode
        let characters = dataTuple.characters
        
        var createdDate = episode.created
        if let date = RMCharacterInfoCollectionViewCellViewModel.dataFormatter.date(from: episode.created) {
            createdDate = RMCharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: date)
        }
        
        self.sections = [.information(viewModels:
                                        [.init(title: "Episode Name", value: episode.name),
                                         .init(title: "Air Date", value: episode.air_date),
                                         .init(title: "Episode", value: episode.episode),
                                         .init(title: "Created", value: createdDate)]),
                         .characters(viewModels: characters.compactMap({ character in
                             RMCharacterCollectionViewCellViewModel(characterName: character.name,
                                                                    characterStatusText: character.status,
                                                                    characterImageUrl: URL(string: character.image))}))]
    }
}

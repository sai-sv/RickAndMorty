//
//  RMLocationDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 04.02.2023.
//

import UIKit

protocol RMLocationDetailViewViewModelDelegate: AnyObject {
    func didFetchLocationDetails()
}

final class RMLocationDetailViewViewModel {
    
    // MARK: - Public Propeties
    weak var delegate: RMLocationDetailViewViewModelDelegate?
    
    enum SectionType {
        case information(viewModels: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModels: [RMCharacterCollectionViewCellViewModel])
    }
    private(set) var sections: [SectionType] = []
    
    // MARK: - Private Properties
    private let endpointUrl: URL?
    private var dataTuple: (location: RMLocation, characters: [RMCharacter])? {
        didSet {
            self.createSections()
            delegate?.didFetchLocationDetails()
        }
    }
    
    // MARK: - Init
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
    }
    
    // MARK: - Public Mthods
    func fetchLocationData() {
        guard let url = endpointUrl, let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request, expecting: RMLocation.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.fetchRelatedCharacters(location: response)
                break
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
    private func fetchRelatedCharacters(location: RMLocation) {
        let requests: [RMRequest] = location.residents
            .compactMap({ URL(string: $0)})
            .compactMap({ RMRequest(url: $0)})
        
        var characters: [RMCharacter] = []
        
        let group = DispatchGroup()
        for requset in requests {
            group.enter()
            RMService.shared.execute(requset, expecting: RMCharacter.self) { result in
                defer {group.leave()}
                switch result {
                case .success(let character):
                    characters.append(character)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        group.notify(queue: .main) {
            self.dataTuple = (location: location, characters: characters)
        }
    }
    
    private func createSections() {
        guard let location = dataTuple?.location,
              let characters = dataTuple?.characters else {
            return
        }
        
        var createdDate = location.created
        if let date = RMCharacterInfoCollectionViewCellViewModel.dataFormatter.date(from: location.created) {
            createdDate = RMCharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: date)
        }
        
        sections = [
            .information(viewModels: [.init(title: "Location Name", value: location.name),
                                      .init(title: "Type", value: location.type),
                                      .init(title: "Dimension", value: location.dimension),
                                      .init(title: "Created", value: createdDate)]),
            .characters(viewModels: characters.compactMap({ character in
                RMCharacterCollectionViewCellViewModel(characterName: character.name,
                                                       characterStatusText: character.status,
                                                       characterImageUrl: URL(string: character.image))
            }))
        ]
    }
}

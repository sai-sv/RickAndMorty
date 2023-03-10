//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 15.01.2023.
//

import Foundation
import UIKit

final class RMCharacterDetailViewViewModel {
    
    // MARK: - Public Properties
    enum SectionType {
        case photo(viewModel: RMCharacterPhotoCollectionViewCellViewModel)
        case information(viewModels: [RMCharacterInfoCollectionViewCellViewModel])
        case episodes(viewModels: [RMCharacterEpisodeCollectionViewCellViewModel])
    }
    var sections: [SectionType] = []
    var title: String {
        return character.name.uppercased()
    }
    var episodes: [String] {
        return character.episode
    }
    
    // MARK: - Private Properties
    private let character: RMCharacter
    
    // MARK: - Init
    init(character: RMCharacter) {
        self.character = character
        setupSections()
    }
    
    // MARK: - Public Methods
    func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func createEpisodesSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                               heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    // MARK: - Private Methods
    private func setupSections() {
        sections = [.photo(viewModel: .init(imageUrl: URL(string: character.image))),
                    .information(viewModels: [.init(type: .status, value: character.status.text),
                                              .init(type: .gender, value: character.gender.rawValue),
                                              .init(type: .type, value: character.type),
                                              .init(type: .species, value: character.species),
                                              .init(type: .origin, value: character.origin.name),
                                              .init(type: .location, value: character.location.name),
                                              .init(type: .created, value: character.created),
                                              .init(type: .episodesCount, value: "\(character.episode.count)")]),
                    .episodes(viewModels: character.episode.compactMap ({
                        RMCharacterEpisodeCollectionViewCellViewModel(episodeUrl: URL(string: $0))
                    }))]
    }
}

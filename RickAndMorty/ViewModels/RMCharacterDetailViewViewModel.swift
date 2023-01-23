//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 15.01.2023.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    
    enum SectionType: CaseIterable {
        case photo
        case information
        case episodes
    }
    
    // MARK: - Public Properties
    var title: String {
        return character.name.uppercased()
    }
    
    let sections = SectionType.allCases
    
    var requestUrl: URL? {
        return URL(string: character.url)
    }
    
    // MARK: - Private Properties
    private let character: RMCharacter
    
    // MARK: - Init
    init(character: RMCharacter) {
        self.character = character
    }
    
}

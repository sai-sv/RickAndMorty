//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 15.01.2023.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    
    // MARK: - Public Properties
    var title: String {
        return character.name.uppercased()
    }
    
    // MARK: - Private Properties
    private let character: RMCharacter
    
    // MARK: - Init
    init(character: RMCharacter) {
        self.character = character
    }
    
}

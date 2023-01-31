//
//  RMEpisodeInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 31.01.2023.
//

import Foundation

final class RMEpisodeInfoCollectionViewCellViewModel {
    
    // MARK: - Public Properties
    let title: String
    let value: String
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}

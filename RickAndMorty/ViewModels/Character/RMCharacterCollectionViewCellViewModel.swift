//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 11.01.2023.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel: Hashable {
    
    // MARK: - Public Properties
    let characterName: String
    var characterStatusText: String {
        return "Status: \(characterStatus.text)"
    }
    
    // MARK: - Private Properties
    private let characterStatus: RMCharacterStatus
    private let characterImageUrl: URL?
    
    // MARK: - Init
    init(characterName: String, characterStatusText: RMCharacterStatus, characterImageUrl: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatusText
        self.characterImageUrl = characterImageUrl
    }
    
    // MARK: - Public Methods
    func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageLoader.shared.downloadImage(url: url, completion: completion)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
    
    static func ==(lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

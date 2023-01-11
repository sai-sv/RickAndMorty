//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 11.01.2023.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel {
    
    let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageUrl: URL?
    
    init(characterName: String, characterStatusText: RMCharacterStatus, characterImageUrl: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatusText
        self.characterImageUrl = characterImageUrl
    }
    
    var characterStatusText: String {
        return characterStatus.rawValue
    }
    
    func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError.init(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}

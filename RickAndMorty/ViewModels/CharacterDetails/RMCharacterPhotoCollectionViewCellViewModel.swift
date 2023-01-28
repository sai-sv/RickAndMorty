//
//  RMCharacterPhotoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 24.01.2023.
//

import Foundation

final class RMCharacterPhotoCollectionViewCellViewModel {
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private let imageUrl: URL?
    
    // MARK: - Init
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    
    // MARK: - Public Methods
    func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = self.imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageLoader.shared.downloadImage(url: imageUrl, completion: completion)
    }
    
    // MARK: - Private Methods
}

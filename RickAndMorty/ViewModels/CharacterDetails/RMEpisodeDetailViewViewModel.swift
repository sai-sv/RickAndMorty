//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 28.01.2023.
//

import UIKit

final class RMEpisodeDetailViewViewModel {

    // MARK: - Private Properties
    private let endpointUrl: URL?
    
    // MARK: - Init
    init(url: URL?) {
        self.endpointUrl = url        
    }
    
    // MARK: - Public Properties
    func fetchEpisodeData() {
        guard let url = endpointUrl, let request = RMRequest(url: url) else { return }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//
//  RMLocationListViewViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 04.02.2023.
//

import Foundation

protocol RMLocationListViewViewModelDelegate: AnyObject {
    func didLoadInitialLocations()
}

final class RMLocationListViewViewModel {
    
    // MARK: - Public Properties
    weak var delegate: RMLocationListViewViewModelDelegate?
    private(set) var viewModels: [RMLocationTableViewCellViewModel] = []
    
    // MARK: - Private Properties
    private var locations: [RMLocation] = [] {
        didSet {
            for location in locations {
                let viewModel = RMLocationTableViewCellViewModel(location: location)
                if !viewModels.contains(viewModel) {
                    viewModels.append(viewModel)
                }
            }
        }
    }
    private var apiInfo: RMGetAllLocationsResponse.Info?
        
    private var shouldLoadMoreLocations: Bool {
        return false
    }
    
    // MARK: - Public Methods
    func fetchLocations() {
        RMService.shared.execute(.locationListRequest, expecting: RMGetAllLocationsResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                guard let self = self else { return }
                self.apiInfo = response.info
                self.locations = response.results
                DispatchQueue.main.async {
                    self.delegate?.didLoadInitialLocations()
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func location(at index: Int) -> RMLocation? {
        guard index >= 0 && index < locations.count else {
            return nil
        }
        return locations[index]
    }
}

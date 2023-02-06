//
//  RMSearchViewViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 06.02.2023.
//

import Foundation

struct RMSearchViewViewModel {
    
    // MARK: - Private Properties
    private let config: RMSearchViewController.Config
    
    // MARK: - Init
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
}
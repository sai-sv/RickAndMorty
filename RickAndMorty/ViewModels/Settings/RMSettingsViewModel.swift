//
//  RMSettingsViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 01.02.2023.
//

import Foundation

struct RMSettingsViewModel {
    
    // MARK: - Private Properties
    private let cellViewModels: [RMSettingsCellViewModel]
    
    // MARK: - Init
    init(viewModels: [RMSettingsCellViewModel]) {
        self.cellViewModels = viewModels
    }
}

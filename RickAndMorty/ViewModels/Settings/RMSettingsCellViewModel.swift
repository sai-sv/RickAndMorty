//
//  RMSettingsCellViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 01.02.2023.
//

import UIKit

struct RMSettingsCellViewModel: Identifiable {
    
    // MARK: - Public Properties
    let id = UUID()
    let type: RMSettingsOption
    var onDidTapHandler: (RMSettingsOption) -> Void
    
    var image: UIImage? {
        return type.iconImage
    }
    
    var title: String {
        return type.diaplayText
    }
    
    var iconContainerView: UIColor {
        return type.iconContainerColor
    }
    
    // MARK: - Init
    init(type: RMSettingsOption, onDidTapHandler: @escaping (RMSettingsOption) -> Void) {
        self.type = type
        self.onDidTapHandler = onDidTapHandler
    }
}

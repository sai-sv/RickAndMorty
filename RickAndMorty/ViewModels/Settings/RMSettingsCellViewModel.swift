//
//  RMSettingsCellViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 01.02.2023.
//

import UIKit

struct RMSettingsCellViewModel: Identifiable, Hashable {
    
    // MARK: - Public Properties
    let id = UUID()
    
    var image: UIImage? {
        return type.iconImage
    }
    
    var title: String {
        return type.diaplayText
    }
    
    var iconContainerView: UIColor {
        return type.iconContainerColor
    }
    
    // MARK: - Private Properties
    private let type: RMSettingsOption
    
    // MARK: - Init
    init(type: RMSettingsOption) {
        self.type = type
    }
}

//
//  RMSettingsViewController.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 29.12.2022.
//

import UIKit

/// Controller to show various app options and settings
final class RMSettingsViewController: UIViewController {

    // MARK: - Private Properties
    private let viewModel = RMSettingsViewModel(viewModels: RMSettingsOption.allCases.compactMap({
        return RMSettingsCellViewModel(type: $0)
    }))
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        view.backgroundColor = .systemBackground        
    }
}

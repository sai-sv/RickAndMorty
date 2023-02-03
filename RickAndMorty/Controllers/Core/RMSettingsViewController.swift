//
//  RMSettingsViewController.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 29.12.2022.
//

import UIKit
import SwiftUI

/// Controller to show various app options and settings
final class RMSettingsViewController: UIViewController {
    
    // MARK: - Private Properties
    private let settingsVC: UIHostingController = {
        let cellViewModels = RMSettingsOption.allCases.compactMap {
            RMSettingsCellViewModel(type: $0)
        }
        let viewModel = RMSettingsViewViewModel(viewModels: cellViewModels)
        
        let vc = UIHostingController(rootView: RMSettingsView(viewModel: viewModel))
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
        
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        view.backgroundColor = .systemBackground
        
        addSettingsView()
        addConstraints()
    }
    
    // MARK: - Private Methods
    private func addSettingsView() {
        addChild(settingsVC)
        settingsVC.didMove(toParent: self)
        view.addSubview(settingsVC.view)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            settingsVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsVC.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingsVC.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            settingsVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

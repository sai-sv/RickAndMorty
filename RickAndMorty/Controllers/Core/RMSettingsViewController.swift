//
//  RMSettingsViewController.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 29.12.2022.
//

import UIKit
import SwiftUI
import SafariServices

/// Controller to show various app options and settings
final class RMSettingsViewController: UIViewController {
    
    // MARK: - Private Properties
    private var settingsVC: UIHostingController<RMSettingsView>?
        
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
        let cellViewModels = RMSettingsOption.allCases.compactMap {
            RMSettingsCellViewModel(type: $0) { [weak self] type in
                self?.didTapOption(type: type)
            }
        }
        
        let viewModel = RMSettingsViewViewModel(viewModels: cellViewModels)
        
        let settingsVC = UIHostingController(rootView: RMSettingsView(viewModel: viewModel))
        settingsVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(settingsVC)
        settingsVC.didMove(toParent: self)
        view.addSubview(settingsVC.view)
        
        self.settingsVC = settingsVC
    }
    
    private func addConstraints() {
        guard let settingsVC = self.settingsVC else { return }
        NSLayoutConstraint.activate([
            settingsVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsVC.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingsVC.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            settingsVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func didTapOption(type: RMSettingsOption) {
        guard Thread.current.isMainThread else { return }
        if let url = type.url {
            let safaryVC = SFSafariViewController(url: url)
            present(safaryVC, animated: true)
        } else if type == .rateApp {
            
        }
    }
}

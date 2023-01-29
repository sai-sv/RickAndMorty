//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 29.12.2022.
//

import UIKit

/// Controller to house tabs and root tab controllers
final class RMTabBarViewController: UITabBarController {

    // MARK: - Lifecycle    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
    }
    
    // MARK: - Private Methods
    private func setupTabs() {
        let charactersVC = createNavigationController(RMCharacterViewController.self, with: "Characters", imageName: "person", tag: 1)
        let locationsVC = createNavigationController(RMLocationViewController.self, with: "Locations", imageName: "globe", tag: 2)
        let episodesVC = createNavigationController(RMEpisodeViewController.self, with: "Episodes", imageName: "tv", tag: 3)
        let settingsVC = createNavigationController(RMSettingsViewController.self, with: "Settings", imageName: "gear", tag: 4)
        
        setViewControllers([charactersVC, locationsVC, episodesVC, settingsVC], animated: true)
    }
    
    private func createNavigationController<T: UIViewController>(_ type: T.Type, with title: String, imageName: String, tag: Int) -> UINavigationController {
        let vc = T()
        vc.navigationItem.largeTitleDisplayMode = .automatic
        
        let navVC = UINavigationController(rootViewController: vc)
        navVC.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: imageName), tag: tag)
        navVC.navigationBar.prefersLargeTitles = true
        return navVC
    }
}


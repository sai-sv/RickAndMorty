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
        let characterVC = RMCharacterViewController()
        let locationVC = RMLocationViewController()
        let episodeVC = RMEpisodeViewController()
        let settingsVC = RMSettingsViewController()
        
        characterVC.navigationItem.largeTitleDisplayMode = .automatic
        locationVC.navigationItem.largeTitleDisplayMode = .automatic
        episodeVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1VC = UINavigationController(rootViewController: characterVC)
        let nav2VC = UINavigationController(rootViewController: locationVC)
        let nav3VC = UINavigationController(rootViewController: episodeVC)
        let nav4VC = UINavigationController(rootViewController: settingsVC)
        
        nav1VC.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 1)
        nav2VC.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "globe"), tag: 2)
        nav3VC.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 3)
        nav4VC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
        
        for nav in [nav1VC, nav2VC, nav3VC, nav4VC] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([nav1VC, nav2VC, nav3VC, nav4VC], animated: true)
    }
}


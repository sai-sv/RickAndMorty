//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 29.01.2023.
//

import UIKit

final class RMSearchViewController: UIViewController {

    // MARK: - Public Properties
    struct Config {
        enum `Type` {
            case character
            case location
            case episode
        }
        
        let type: Type
    }
    
    // MARK: - Private Properties
    let config: Config
    
    // MARK: - Init
    init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        view.backgroundColor = .systemRed
    }
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
}

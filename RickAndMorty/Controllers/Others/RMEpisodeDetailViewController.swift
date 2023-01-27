//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 27.01.2023.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {

    // MARK: - Private Properties
    private var url: URL?
    
    // MARK: - Init
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemMint
    }
}

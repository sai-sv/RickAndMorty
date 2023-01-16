//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 15.01.2023.
//

import UIKit

class RMCharacterDetailViewController: UIViewController {
    
    private var viewModel: RMCharacterDetailViewViewModel
    
    // MARK: - Init
    init(viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }

}
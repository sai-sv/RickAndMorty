//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 27.01.2023.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {

    // MARK: - Private Properties
    private let detailView = RMEpisodeDetailView()
    private let viewModel: RMEpisodeDetailViewViewModel
    
    // MARK: - Init
    init(url: URL?) {
        self.viewModel = RMEpisodeDetailViewViewModel(url: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Episode"
        view.backgroundColor = .systemBackground
        
        addShareButton()
        
        view.addSubview(detailView)
        addConstraints()
    }
    
    // MARK: - Private Methods
    private func addShareButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
    }
    
    @objc private func didTapShare() {
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

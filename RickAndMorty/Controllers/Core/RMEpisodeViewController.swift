//
//  RMEpisodeViewController.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 29.12.2022.
//

import UIKit

/// Controller to show and search for Episodes
final class RMEpisodeViewController: UIViewController {
    
    // MARK: - Private Properties
    private let episodeListView = RMEpisodeListView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Episodes"
        view.backgroundColor = .systemBackground
        
        addSearchButton()
        
        view.addSubview(episodeListView)
        addConstraints()
        
        episodeListView.delegate = self
    }
    
    // MARK: - Private Methods
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            episodeListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - RMEpisodeListViewDelegate
extension RMEpisodeViewController: RMEpisodeListViewDelegate {
    
    func rmEpisodeListView(_ episodeListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode) {
        let detailVC = RMEpisodeDetailViewController(url: URL(string: episode.url))
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

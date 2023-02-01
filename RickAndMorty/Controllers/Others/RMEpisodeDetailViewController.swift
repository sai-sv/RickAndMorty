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
    init(endpointUrl: URL?) {
        self.viewModel = RMEpisodeDetailViewViewModel(endpointUrl: endpointUrl)
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
        
        detailView.delegate = self
        
        viewModel.delegate = self
        viewModel.fetchEpisodeData()
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

// MARK: - RMEpisodeDetailViewViewModel Delegate
extension RMEpisodeDetailViewController: RMEpisodeDetailViewViewModelDelegate {
    
    func didFetchEpisodeDetails() {
        detailView.configure(with: viewModel)
    }
}

// MARK: - DetailView Delegate
extension RMEpisodeDetailViewController: RMEpisodeDetailViewDelegate {
    
    func rmEpisodeDetailView(_ detailView: RMEpisodeDetailView, didSelect character: RMCharacter) {
        let vc = RMCharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

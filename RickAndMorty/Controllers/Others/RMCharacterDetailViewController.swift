//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 15.01.2023.
//

import UIKit

final class RMCharacterDetailViewController: UIViewController {
    
    // MARK: - Private Properties
    private var viewModel: RMCharacterDetailViewViewModel    
    private let detailView: RMCharacterDetailView
    
    // MARK: - Init
    init(viewModel: RMCharacterDetailViewViewModel) {        
        self.viewModel = viewModel
        self.detailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = viewModel.title
        
        view.addSubview(detailView)
        addConstraints()
        
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self,
                                                            action: #selector(didTapShare))
    }
    
    // MARK: - Private Methods
    @objc private func didTapShare() {
        // TODO:...
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

// MARK: - UICollectionView Delegate & DataSource
extension RMCharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case .photo:
            return 1
        case .information(let viewModels):
            return viewModels.count
        case .episodes(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section] {
        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterPhotoCollectionViewCell.identifier, for: indexPath)
                    as? RMCharacterPhotoCollectionViewCell else { fatalError() }
            cell.configure(with: viewModel)
            return cell
            
        case .information(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterInfoCollectionViewCell.identifier, for: indexPath)
                    as? RMCharacterInfoCollectionViewCell else { fatalError() }
            cell.configure(with: viewModels[indexPath.row])
            return cell
            
        case .episodes(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier, for: indexPath)
                    as? RMCharacterEpisodeCollectionViewCell else { fatalError() }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
    }
    
    // select
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch viewModel.sections[indexPath.section] {
        case .photo, .information:
            break
        case .episodes:
            let episodes = viewModel.episodes
            let episodeUrl = episodes[indexPath.row]            
            let vc = RMEpisodeDetailViewController(url: URL(string: episodeUrl))
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

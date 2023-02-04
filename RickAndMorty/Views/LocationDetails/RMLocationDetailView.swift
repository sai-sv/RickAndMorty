//
//  RMLocationDetailView.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 04.02.2023.
//

import UIKit

protocol RMLocationDetailViewDelegate: AnyObject {
    func rmLocationDetailView(_ detailView: RMLocationDetailView, didSelect character: RMCharacter)
}

final class RMLocationDetailView: UIView {

    // MARK: - Public Properties
    weak var delegate: RMLocationDetailViewDelegate?
    
    // MARK: - Private Properties
    private var collectionView: UICollectionView?
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private var viewModel: RMLocationDetailViewViewModel? {
        didSet {
            spinner.stopAnimating()
            collectionView?.isHidden = false
            collectionView?.reloadData()
            UIView.animate(withDuration: 0.4) {
                self.collectionView?.alpha = 1
            }
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        
        let collectionView = createCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView = collectionView
        
        addSubview(collectionView)
        addSubview(spinner)
        addConstraints()
        
        spinner.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with model: RMLocationDetailViewViewModel) {
        self.viewModel = model
    }
    
    // MARK: - Private Methods
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            return self.createCollectionViewLayout(for: section)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.register(RMEpisodeInfoCollectionViewCell.self, forCellWithReuseIdentifier: RMEpisodeInfoCollectionViewCell.cellIdentifier)
        collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier)
        return collectionView
    }
    
    private func createCollectionViewLayout(for sectionIndex: Int) -> NSCollectionLayoutSection {
        guard let sections = self.viewModel?.sections else {
            return createLocationInfoSectionLayout()
        }
        
        switch sections[sectionIndex] {
        case .information:
            return self.createLocationInfoSectionLayout()
        case .characters:
            return self.createCharactersSectionLayout()
        }
    }
    
    private func createLocationInfoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                       heightDimension: .absolute(80)),
                                                     subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createCharactersSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                            heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                       heightDimension: .absolute(260)),
                                                     subitems: [item, item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
        
    private func addConstraints() {
        guard let collectionView = self.collectionView else { return }
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
        ])
    }
}

// MARK: CollectionView Delegate & DataSource
extension RMLocationDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.sections.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = viewModel?.sections else { return 0}
        switch sections[section] {
        case .information(let viewModels):
            return viewModels.count
        case .characters(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sections = viewModel?.sections else {
            fatalError("No Sections")
        }
        
        switch sections[indexPath.section] {
        case .information(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMEpisodeInfoCollectionViewCell.cellIdentifier, for: indexPath)
                    as? RMEpisodeInfoCollectionViewCell else {
                fatalError("No Cell")
            }
            let cellViewModel = viewModels[indexPath.row]
            cell.configure(with: cellViewModel)
            return cell
            
        case .characters(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath)
                    as? RMCharacterCollectionViewCell else {
                fatalError("No Cell")
            }
            let cellViewModel = viewModels[indexPath.row]
            cell.configure(with: cellViewModel)
            return cell
        }
    }
    
    // select
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let sections = self.viewModel?.sections else {
            return
        }
        
        switch sections[indexPath.section] {
        case .information:
            break
        case .characters:
            guard let character = self.viewModel?.character(at: indexPath.row) else { return }
            delegate?.rmLocationDetailView(self, didSelect: character)
            break
        }
    }
}

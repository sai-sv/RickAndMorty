//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 24.01.2023.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    static let cellIdentifier = "RMCharacterEpisodeCollectionViewCell"
    
    // MARK: - Private Properties
    private let episodeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let airDateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.systemBlue.cgColor
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .tertiarySystemBackground
        
        contentView.addSubview(episodeLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(airDateLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        episodeLabel.text = nil
        nameLabel.text = nil
        airDateLabel.text = nil
    }
    
    // MARK: - Public Methods
    func configure(with viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        viewModel.registerBlock { [weak self] data in
            // Main Queue
            guard let self = self else { return }
            self.episodeLabel.text = "Episode \(data.episode)"
            self.nameLabel.text = data.name
            self.airDateLabel.text = "Aired on \(data.air_date)"
        }
        viewModel.fetchEpisode()
    }
    
    // MARK: - Private Methods
    private func addConstraints() {
        NSLayoutConstraint.activate([
            episodeLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            episodeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            episodeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            episodeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            nameLabel.topAnchor.constraint(equalTo: episodeLabel.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
                        
            airDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            airDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            airDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
        ])
    }
}

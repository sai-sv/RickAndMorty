//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 24.01.2023.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    static let identifier = "RMCharacterEpisodeCollectionViewCell"
    
    // MARK: - Private Properties
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .tertiarySystemBackground
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Public Methods
    func configure(with viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        
    }
    
    // MARK: - Private Methods
    private func addConstraints() {
        
    }
}

//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 24.01.2023.
//

import UIKit

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    static let identifier = "RMCharacterInfoCollectionViewCell"
    
    // MARK: - Private Properties
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
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
    func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel) {
        
    }
    
    // MARK: - Private Methods
    private func addConstraints() {
        
    }
}

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
    private let imageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let titleContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .tertiarySystemBackground
        
        titleContainerView.addSubview(titleLabel)
        contentView.addSubview(titleContainerView)
        contentView.addSubview(valueLabel)
        contentView.addSubview(imageView)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageView.tintColor = .label
        valueLabel.text = nil
        titleLabel.text = nil
        titleLabel.textColor = .label
    }
    
    // MARK: - Public Methods
    func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel) {
        imageView.image = viewModel.icon
        imageView.tintColor = viewModel.tintColor
        valueLabel.text = viewModel.displayValue
        titleLabel.text = viewModel.displayTitle
        titleLabel.textColor = viewModel.tintColor
    }
    
    // MARK: - Private Methods
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 30),
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            valueLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            valueLabel.bottomAnchor.constraint(equalTo: titleContainerView.topAnchor),
            
            titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            titleContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: titleContainerView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: titleContainerView.rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
        ])
    }
}

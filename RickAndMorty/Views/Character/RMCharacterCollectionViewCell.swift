//
//  RMCharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 11.01.2023.
//

import UIKit

final class RMCharacterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    static let cellIdentifier = "RMCharacterCollectionViewCell"
    
    // MARK: - Private Properties
    private let imageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusLabel)
        
        addConstraints()
        setupLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        nameLabel.text = ""
        statusLabel.text = ""
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupLayer()
    }
    
    // MARK: - Public Methods
    func configure(with viewModel: RMCharacterCollectionViewCellViewModel) {
        nameLabel.text = viewModel.characterName
        statusLabel.text = viewModel.characterStatusText
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    // MARK: - Private Methods
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3),
            
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            
            statusLabel.heightAnchor.constraint(equalToConstant: 30),
            statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7)
        ])
    }
    
    private func setupLayer() {
        contentView.layer.cornerRadius = 4
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowOpacity = 0.3
    }
    
    
}

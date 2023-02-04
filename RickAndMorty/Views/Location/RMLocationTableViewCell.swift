//
//  RMLocationTableViewCell.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 04.02.2023.
//

import UIKit

class RMLocationTableViewCell: UITableViewCell {

    // MARK: - Public Properties
    static let identifier: String = "RMLocationTableViewCell"
    
    // MARK: - Private Properties
    private let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let dimensionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private var viewModel: RMLocationTableViewCellViewModel?
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .systemBackground
        accessoryType = .disclosureIndicator
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(dimensionLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        typeLabel.text = nil
        dimensionLabel.text = nil
    }
    
    // MARK: - Public Methods
    func configure(with model: RMLocationTableViewCellViewModel) {
        nameLabel.text = model.name
        typeLabel.text = model.type
        dimensionLabel.text =  model.dimension
    }
    
    // MARK: - Private Methods
    private func addConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            typeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            typeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            dimensionLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10),
            dimensionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            dimensionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            dimensionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}

//
//  RMNoSearchResultsView.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 06.02.2023.
//

import UIKit

final class RMNoSearchResultsView: UIView {
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private let iconView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .systemGreen
        return iv
    }()
    
    private let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private let viewModel: RMNoSearchResultsViewViewModel
    
    // MARK: - Init
    init(viewModel: RMNoSearchResultsViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        
        isHidden = true
        
        addSubview(iconView)
        addSubview(label)
        addConstraints()
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    private func configure() {
        iconView.image = viewModel.image
        label.text = viewModel.title
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 90),
            iconView.heightAnchor.constraint(equalToConstant: 90),
            iconView.topAnchor.constraint(equalTo: topAnchor),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            label.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10),
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

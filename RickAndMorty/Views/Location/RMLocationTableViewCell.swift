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
    private var viewModel: RMLocationTableViewCellViewModel?
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        // TODO
    }
    
    // MARK: - Public Methods
    func configure(with model: RMLocationTableViewCellViewModel) {
        viewModel = model
    }
}

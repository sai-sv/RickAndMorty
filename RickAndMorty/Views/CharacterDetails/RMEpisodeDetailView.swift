//
//  RMEpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 28.01.2023.
//

import UIKit

final class RMEpisodeDetailView: UIView {

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

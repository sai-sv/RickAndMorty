//
//  RMCharacterDetailView.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 15.01.2023.
//

import UIKit

final class RMCharacterDetailView: UIView {

    // MARK: - Init
    init(viewModel: RMCharacterListViewViewModel) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

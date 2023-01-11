//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 08.01.2023.
//

import Foundation
import UIKit

final class RMCharacterListViewViewModel: NSObject {

    func fetchCharacters() {
        let request = RMRequest(endpoint: .character)
        
        RMService.shared.execute(request, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let response):
                print(response)
                break
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension RMCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIndentifier, for: indexPath) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        
        let viewModel = RMCharacterCollectionViewCellViewModel(characterName: "Same",
                                                               characterStatusText: .alive,
                                                               characterImageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/20.jpeg"))
        cell.configure(viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.5)
    }
}

//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 29.12.2022.
//

import UIKit

/// Controller to show and search for Characters
final class RMCharacterViewController: UIViewController {

    private struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        let pathComponents: [String] = ["1", "2", "3", "4",]
        
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

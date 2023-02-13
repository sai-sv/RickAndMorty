//
//  RMSearchViewViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 06.02.2023.
//

import Foundation

final class RMSearchViewViewModel {
    
    // MARK: - Public Properties
    typealias BlockTuple = (option: RMSearchInputViewViewModel.DynamicOption, choice: String)
    let config: RMSearchViewController.Config
    
    // MARK: - Private Properties
    private var optionMap: [RMSearchInputViewViewModel.DynamicOption: String] = [:]
    private var optionMapUpdateBlock: ((BlockTuple) -> Void)?
    private var searchText = ""
    
    // MARK: - Init
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
    
    // MARK: - Public Methods
    func set(choice: String, for option: RMSearchInputViewViewModel.DynamicOption) {
        optionMap[option] = choice
        
        let tuple = (option: option, choice: choice)
        optionMapUpdateBlock?(tuple)
    }
    
    func registerOptionChangeBlock(_ block: @escaping (BlockTuple) -> Void) {
        optionMapUpdateBlock = block
    }
    
    func executeSearch() {
        
    }
    
    func set(query text: String) {
        searchText = text
    }
}

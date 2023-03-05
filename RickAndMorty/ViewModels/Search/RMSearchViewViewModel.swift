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
    private var searchResultHandler: (() -> Void)?
    
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
    
    func registerSearchResultHandler(_ block: @escaping () -> Void) {
        searchResultHandler = block
    }
    
    func executeSearch() {
        var queryItems = [URLQueryItem(name: "name",
                                       value: searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))]
        let options = optionMap.enumerated().compactMap { _, element in
            URLQueryItem(name: element.key.queryItemName, value: element.value)
        }
        queryItems.append(contentsOf: options)
        
        let request = RMRequest(endpoint: config.type.endpoint, queryItems: queryItems)
        
        print(request.url?.absoluteURL)
        
        RMService.shared.execute(request, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                print(response.results)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func set(query text: String) {
        searchText = text
    }
}

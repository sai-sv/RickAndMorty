//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 29.01.2023.
//

import UIKit

final class RMSearchViewController: UIViewController {

    // MARK: - Public Properties
    struct Config {
        enum `Type` {
            case character
            case location
            case episode
            
            var title: String {
                switch self {
                case .character:
                    return "Search Character"
                case .location:
                    return "Search Location"
                case .episode:
                    return "Search Episode"
                }
            }
        }
        
        let type: Type
    }
    
    // MARK: - Private Properties
    private let searchView: RMSearchView
    private let viewModel: RMSearchViewViewModel
    
    // MARK: - Init
    init(config: Config) {
        let viewModel = RMSearchViewViewModel(config: config)
        self.viewModel = viewModel
        self.searchView = RMSearchView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        
        view.addSubview(searchView)
        addConstraints()
        
        searchView.delegate = self        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.config.type.title
        view.backgroundColor = .systemBackground
        
        addSearchButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchView.showKeyboard()
    }
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(searchDidTap))
    }
    
    @objc private func searchDidTap() {
        viewModel.executeSearch()
    }
}

// MARK: - SearchView Delegate
extension RMSearchViewController: RMSearchViewDelegate {
    
    func rmSearchView(_ searchView: RMSearchView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
        let vc = RMSearchOptionPickerViewController(option: option) { [weak self] choice in
            DispatchQueue.main.async {
                self?.viewModel.set(choice: choice, for: option)
            }
        }
        vc.sheetPresentationController?.prefersGrabberVisible = true
        vc.sheetPresentationController?.detents = [.medium()]
        
        present(vc, animated: true)
    }
}

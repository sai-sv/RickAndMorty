//
//  RMLocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 04.02.2023.
//

import UIKit

final class RMLocationDetailViewController: UIViewController {

    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private let detailView = RMLocationDetailView()
    private let viewModel: RMLocationDetailViewViewModel
    
    // MARK: - Init
    init(endpointUrl: URL?) {
        self.viewModel = RMLocationDetailViewViewModel(endpointUrl: endpointUrl)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Location"
        view.backgroundColor = .systemBackground
        
        addShareButton()
        
        view.addSubview(detailView)
        addConstraints()
        
        detailView.delegate = self
        
        viewModel.delegate = self
        viewModel.fetchLocationData()
    }
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    private func addShareButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
    }
    
    @objc private func didTapShare() {
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - DetailView Delegate
extension RMLocationDetailViewController: RMLocationDetailViewDelegate {
    
    func rmLocationDetailView(_ detailView: RMLocationDetailView, didSelect character: RMCharacter) {
        let vc = RMCharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - ViewModel Delegate
extension RMLocationDetailViewController: RMLocationDetailViewViewModelDelegate {
    
    func didFetchLocationDetails() {
        detailView.configure(with: viewModel)
    }
}

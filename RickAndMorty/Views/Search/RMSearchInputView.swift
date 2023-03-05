//
//  RMSearchInputView.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 06.02.2023.
//

import UIKit

protocol RMSearchInputViewDelegate: AnyObject {
    func rmSearchInputView(_ searchInputView: RMSearchInputView,
                           didSelectOption option: RMSearchInputViewViewModel.DynamicOption)
    func rmSearchInputView(_ searchInputView: RMSearchInputView,
                           textDidChange text: String)
    func rmSearchInputViewDidTapSeachButton(_ searchInputView: RMSearchInputView)
}

final class RMSearchInputView: UIView {
    
    // MARK: - Public Properties
    weak var delegate: RMSearchInputViewDelegate?
    
    // MARK: - Private Properties
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    private var stackView: UIStackView?
    
    private var viewModel: RMSearchInputViewViewModel? {
        didSet {
            guard let viewModel = viewModel, viewModel.hasDynamicOptions else { return }
            let options = viewModel.options
            createOptionSelectionViews(options: options)
        }
    }
        
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        
        addSubview(searchBar)
        addConstraints()
        
        searchBar.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with model: RMSearchInputViewViewModel) {
        searchBar.placeholder = model.searchPlaceholderText
        viewModel = model
    }
    
    func showKeyboard() {
        searchBar.becomeFirstResponder()
    }
    
    func update(option: RMSearchInputViewViewModel.DynamicOption, choice: String) {
        guard let buttons = stackView?.arrangedSubviews as? [UIButton],
              let index = viewModel?.options.firstIndex(of: option) else {
            return
        }
        
        let button = buttons[index]
        let buttonTitle = createButtonTitle(with: choice.capitalized, color: UIColor.link)
        button.setAttributedTitle(buttonTitle, for: .normal)
    }
    
    // MARK: - Private Methods
    private func createOptionSelectionViews(options: [RMSearchInputViewViewModel.DynamicOption]) {
        let stackView = createStackView()
        for index in 0..<options.count {
            let option = options[index]
            let button = createButton(with: option, tag: index)
            stackView.addArrangedSubview(button)
        }
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView(frame: .zero)
        self.stackView = stackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 6
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 6),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -6),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        return stackView
    }
    
    private func createButton(with option: RMSearchInputViewViewModel.DynamicOption, tag: Int) -> UIButton {
        let button = UIButton(frame: .zero)
        let buttonTitle = createButtonTitle(with: option.rawValue, color: UIColor.label)
        button.setAttributedTitle(buttonTitle, for: .normal)
        button.backgroundColor = .secondarySystemFill
        button.tag = tag
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        return button
    }
    
    private func createButtonTitle(with text: String, color: UIColor) -> NSAttributedString {
        return NSAttributedString(string: text,
                                  attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                               .foregroundColor: color])
    }
    
    @objc private func buttonDidTap(_ sender: UIButton) {
        guard let options = viewModel?.options else {
            return
        }
        let option = options[sender.tag]
        delegate?.rmSearchInputView(self, didSelectOption: option)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchBar.heightAnchor.constraint(equalToConstant: 55),
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}

// MARK: - SearchBar Delegate
extension RMSearchInputView: UISearchBarDelegate {
 
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.rmSearchInputView(self, textDidChange: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        delegate?.rmSearchInputViewDidTapSeachButton(self)
    }
}

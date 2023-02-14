//
//  RMSearchInputViewViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 06.02.2023.
//

import Foundation

final class RMSearchInputViewViewModel {
    
    // MARK: - Public Properties
    enum DynamicOption: String {
        case gender = "Gender"
        case status = "Status"
        case locationType = "Location Type"
        
        var choices: [String] {
            switch self {
            case .gender:
                return ["male", "female", "genderless", "unknown"]
            case .status:
                return ["alive", "dead", "unknown"]
            case .locationType:
                return ["cluster", "planet", "microverse"]
            }
        }
        
        var queryItemName: String {
            switch self {
            case .gender:
                return "gender"
            case .status:
                return "status"
            case .locationType:
                return "type"
            }
        }
    }
    
    var options: [DynamicOption] {
        switch self.type {
        case .character:
            return [.gender, .status]
        case .location:
            return [.locationType]
        case .episode:
            return []
        }
    }
    
    var hasDynamicOptions: Bool {
        switch self.type {
        case .character, .location:
            return true
        case .episode:
            return false
        }
    }
    
    var searchPlaceholderText: String {
        switch self.type {
        case .character:
            return "Character Name"
        case .location:
            return "Location Name"
        case .episode:
            return "Episode Title"
        }
    }
    
    // MARK: - Private Properties
    private let type: RMSearchViewController.Config.`Type`
    
    // MARK: - Init
    init(type: RMSearchViewController.Config.`Type`) {
        self.type = type
    }
}

//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 24.01.2023.
//

import UIKit

final class RMCharacterInfoCollectionViewCellViewModel {
    
    // MARK: - Public Properties
    enum InfoType: String {
        case status
        case gender
        case type
        case species
        case origin
        case location
        case created
        case episodesCount = "EPISODE COUNT"
        
        var title: String {
            return rawValue.uppercased()
        }
        
        var icon: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "bell")
            case .gender:
                return UIImage(systemName: "bell")
            case .type:
                return UIImage(systemName: "bell")
            case .species:
                return UIImage(systemName: "bell")
            case .origin:
                return UIImage(systemName: "bell")
            case .location:
                return UIImage(systemName: "bell")
            case .created:
                return UIImage(systemName: "bell")
            case .episodesCount:
                return UIImage(systemName: "bell")
            }
        }
        
        var color: UIColor {
            switch self {
            case .status:
                return .systemMint
            case .gender:
                return .systemRed
            case .type:
                return .systemBlue
            case .species:
                return .systemYellow
            case .origin:
                return .systemPurple
            case .location:
                return .systemGreen
            case .created:
                return .systemOrange
            case .episodesCount:
                return .systemPink
            }
        }
    }
    
    var displayTitle: String {
        return type.title
    }
    var icon: UIImage? {
        return type.icon
    }
    var tintColor: UIColor {
        return type.color
    }
    var displayValue: String {
        if value.isEmpty { return "None" }
        if type == .created, let date = Self.dataFormatter.date(from: value) {
            return Self.shortDateFormatter.string(from: date)
        }
        return value
    }
    
    // MARK: - Private Properties
    private let type: InfoType
    private let value: String
    
    private static let dataFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = .current
        return dateFormatter
    }()
    
    private static let shortDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = .current
        return dateFormatter
    }()
    
    // MARK: - Public Methods
    
    // MARK: - Init
    init(type: InfoType, value: String) {
        self.type = type
        self.value = value
    }
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
}

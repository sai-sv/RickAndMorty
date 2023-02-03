//
//  RMSettingsOption.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 01.02.2023.
//

import UIKit

enum RMSettingsOption: CaseIterable {
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewSeries
    case viewCode
    
    var diaplayText: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact Us"
        case .terms:
            return "Terms of Service"
        case .privacy:
            return "Privacy Policy"
        case .apiReference:
            return "API Reference"
        case .viewSeries:
            return "View Video Series"
        case .viewCode:
            return "View App Code"
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contactUs:
            return UIImage(systemName: "paperplane")
        case .terms:
            return UIImage(systemName: "doc")
        case .privacy:
            return UIImage(systemName: "lock")
        case .apiReference:
            return UIImage(systemName: "list.clipboard")
        case .viewSeries:
            return UIImage(systemName: "tv.fill")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")
        }
    }
    
    var iconContainerColor: UIColor {
        switch self {
        case .rateApp:
            return .systemRed
        case .contactUs:
            return .systemYellow
        case .terms:
            return .systemMint
        case .privacy:
            return .systemPink
        case .apiReference:
            return .systemBlue
        case .viewSeries:
            return .systemPurple
        case .viewCode:
            return .systemOrange
        }
    }
    
    var url: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https://www.apple.com/contact/")
        case .terms:
            return URL(string: "https://www.apple.com/legal/internet-services/itunes/")
        case .privacy:
            return URL(string: "https://www.apple.com/ru/privacy/")
        case .apiReference:
            return URL(string: "https://rickandmortyapi.com/api/")
        case .viewSeries:
            return URL(string: "https://youtube.com/playlist?list=PL5PR3UyfTWvdl4Ya_2veOB6TM16FXuv4y")
        case .viewCode:
            return URL(string: "https://rickandmortyapi.com/documentation/")
        }
    }
}

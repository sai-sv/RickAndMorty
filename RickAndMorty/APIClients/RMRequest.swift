//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 30.12.2022.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

/// Object that represents a single API call
final class RMRequest {
    
    private struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api"
    }
    
    let method: HttpMethod = .get
    
    // MARK: - Private Properties
    private let endpoint: RMEndpoint
    private let pathComponents: [String]
    private let queryItems: [URLQueryItem]
    
    // MARK: - Public Properties
    var url: URL? {
        let string = pathComponents.reduce(Constants.baseURL + "/" + endpoint.rawValue) { $0 + "/" + $1 }
        
        guard let url = URL(string: string),
              var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        
        return components.url
    }
    
    // MARK: - Init
    init(endpoint: RMEndpoint, pathComponents: [String] = [], queryItems: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryItems = queryItems
    }
    
    convenience init?(url: URL) {
        let string = url.absoluteString
        guard string.contains(Constants.baseURL + "/"),
              case let replacedString = string.replacingOccurrences(of: Constants.baseURL + "/", with: ""),
              let components = URLComponents(string: replacedString),
              let endpoint = components.path.components(separatedBy: "/").first,
              let rmEndpoint = RMEndpoint(rawValue: endpoint) else {
            return nil
        }
        self.init(endpoint: rmEndpoint, queryItems: components.queryItems ?? [])
    }
    
}

extension RMRequest {
    static let listCharactersRequests = RMRequest(endpoint: .character)
}

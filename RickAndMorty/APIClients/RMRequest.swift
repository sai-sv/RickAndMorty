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
    
    // MARK: - Public Properties
    let method: HttpMethod = .get
    let endpoint: RMEndpoint
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
    
    // MARK: - Private Properties
    private struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api"
    }
    private let pathComponents: [String]
    private let queryItems: [URLQueryItem]
    
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
              case var pathComponents = components.path.components(separatedBy: "/"), !pathComponents.isEmpty,
              case let endpoint = pathComponents.removeFirst(),
              let rmEndpoint = RMEndpoint(rawValue: endpoint) else {
            return nil
        }
        self.init(endpoint: rmEndpoint, pathComponents: pathComponents, queryItems: components.queryItems ?? [])
    }
}

extension RMRequest {
    static let listCharactersRequests = RMRequest(endpoint: .character)
}

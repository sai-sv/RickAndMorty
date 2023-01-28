//
//  RMService.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 30.12.2022.
//

import Foundation

/// Primary API service object to get Rick and Morty data
final class RMService {
    // MARK: - Public Properties
    enum RMServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// Shared singleton instance
    static let shared = RMService()
        
    // MARK: - Private Properties
    private let cacheManager = RMAPICacheManager()
    
    // MARK: - Init
    /// Privatized constructor
    private init() {}
    
    // MARK: - Public Methods
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type of object we expect to get back
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(_ request: RMRequest, expecting type: T.Type,
                                    completion: @escaping (Result<T, Error>) -> Void) {
        
        // load from cache
        if let url = request.url, let cachedData = cacheManager.cacheResponse(endpoint: request.endpoint, url: url) {
            do {
                let result = try JSONDecoder().decode(type.self, from: cachedData)
                print("Using cached API response")
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
            return
        }
        
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        
        print("API CALL: \(urlRequest.url!.absoluteString)")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            
            // Decode reponse
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                // save to cache
                if let url = request.url {
                    self?.cacheManager.storeCache(endpoint: request.endpoint, url: url, data: data)
                }
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    // MARK: - Private Methods
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.method.rawValue
        
        return request
    }
}

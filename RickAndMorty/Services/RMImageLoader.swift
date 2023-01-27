//
//  RMImageLoader.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 18.01.2023.
//

import Foundation

final class RMImageLoader {
    
    static var shared = RMImageLoader()
    
    // MARK: - Private Properties
    private var imageDataCache = NSCache<NSString, NSData>()
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Public Methods
    func downloadImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        // load from cache
        let key = url.absoluteString as NSString
        if let data = self.imageDataCache.object(forKey: key) as? Data {
            completion(.success(data))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else {
                completion(.failure(error ?? URLError.init(.badServerResponse)))
                return
            }
            
            // save to cache
            let value = data as NSData
            self.imageDataCache.setObject(value, forKey: key)
            completion(.success(data))
        }
        task.resume()
    }
}

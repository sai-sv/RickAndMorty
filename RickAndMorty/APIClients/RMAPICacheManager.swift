//
//  RMAPICacheManager.swift
//  RickAndMorty
//
//  Created by Sergei Sai on 28.01.2023.
//

import Foundation

final class RMAPICacheManager {
    
    // MARK: - Private Properties
    private var cache = [RMEndpoint: NSCache<NSString, NSData>]()
    
    // MARK: - Init
    init() {
        RMEndpoint.allCases.forEach { endpoint in
            cache[endpoint] = NSCache<NSString, NSData>()
        }
    }
    
    // MARK: - Public Methods
    func cacheResponse(endpoint: RMEndpoint, url: URL) -> Data? {
        guard let targetCache = cache[endpoint] else { return nil }
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    func storeCache(endpoint: RMEndpoint, url: URL, data: Data) {
        let key = url.absoluteString as NSString        
        cache[endpoint]?.setObject(data as NSData, forKey: key)
    }
}

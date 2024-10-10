//
//  URLCacheManager.swift
//  NewsReader
//
//  Created by Varun Mehta on 10/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import Foundation

protocol URLCacheManagerProtocol {
    func cachedResponse(for request: URLRequest) -> CachedURLResponse?
    func storeResponse(_ response: URLResponse, for request: URLRequest, data: Data)
}

class URLCacheManager {
    static let shared = URLCacheManager()
    private let cache: URLCache
    
    private init() {
        // Configure URLCache
        let memoryCapacity =  AppConstants.Cache.memoryCapacity
        let diskCapacity = AppConstants.Cache.memoryCapacity
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: AppConstants.Cache.path)
        self.cache = cache
    }
}

extension URLCacheManager: URLCacheManagerProtocol {
    // Retrieve cached response for a given URL request
    func cachedResponse(for request: URLRequest) -> CachedURLResponse? {
        return cache.cachedResponse(for: request)
    }
    
    // Store a response in the cache for a given URL request
    func storeResponse(_ response: URLResponse, for request: URLRequest, data: Data) {
        let cachedResponse = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedResponse, for: request)
    }    
}

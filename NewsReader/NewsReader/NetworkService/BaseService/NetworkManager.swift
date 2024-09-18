//
//  NetworkManager.swift
//  NewsReader
//
//  Created by Varun Mehta on 10/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import Foundation
import Combine

protocol Fetchable {
    func fetch<T: Decodable>(with endpoint: Endpoint) async throws -> T
    func fetch<T: Decodable>(with endpoint: Endpoint) -> AnyPublisher<T?, APIError>
}

class NetworkManager {
    private let cacheManager: URLCacheManagerProtocol
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = AppConstants.Network.kRequestTimeOut
        return URLSession(configuration: configuration)
    }()
    
    init(cacheManager: URLCacheManagerProtocol = URLCacheManager.shared) {
        self.cacheManager = cacheManager
    }
}

extension NetworkManager: Fetchable {
    func fetch<T: Decodable>(with endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw APIError.invalidRequest(message: "Invalid URL: \(String(describing: endpoint.url))")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONParser.decode(data)
        } catch {
            throw APIError.requestFailed(mesage: "Request Failed! Please check your connectivity or try again.")
        }
    }
    
    func fetch<T: Decodable>(with endpoint: Endpoint) -> AnyPublisher<T?, APIError> {
        guard let url = endpoint.url else {
            return Fail(error: APIError.invalidRequest(message: "Invalid URL"))
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Publisher for cached response
        let cachedPublisher = Future<T?, APIError> { [weak self] promise in
            guard let self = self else { return }
            do {
                if let cachedResponse = self.cacheManager.cachedResponse(for: request) {
                    promise(.success(try JSONParser.decode(cachedResponse.data)))
                } else {
                    promise(.success(nil))
                }
            }
            catch {
                promise(.success(nil))
            }
        }
        
        // Publisher for fresh response
        let freshDataPublisher = session.dataTaskPublisher(for: request)
            .tryMap { [weak self] data, response -> T? in
                // Cache the new response
                if endpoint.cacheSupport {
                    self?.cacheManager.storeResponse(response, for: request, data: data)
                }
                return try JSONParser.decode(data)
            }
            .mapError {
                APIError.map($0)
            }
            .eraseToAnyPublisher()
        
        return Publishers.Merge(cachedPublisher, freshDataPublisher)
            .eraseToAnyPublisher()
        
    }
}

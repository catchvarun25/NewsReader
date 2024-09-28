//
//  MockNetworkManager.swift
//  NewsReaderTests
//
//  Created by Varun Mehta on 27/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import Foundation
import Combine

@testable import NewsReader

class MockNetworkManager: Fetchable {
    var result: AnyPublisher<Any?, APIError>?

    internal func fetch<T: Decodable>(with endpoint: NewsReader.Endpoint) async throws -> T {
        guard let result = result else {
            throw APIError.requestFailed(mesage: "NR: Request Failed")
        }
        // Use `await` to wait for the result from the publisher
        return try await result.tryMap { value in
            if let convertedValue = value as? T {
                return convertedValue
            } else {
                throw APIError.other(message: "Invalid Value")
            }
        }.firstValueAsync()
    }
    
    internal func fetch<T: Decodable>(with endpoint: Endpoint) -> AnyPublisher<T?, APIError> {
        guard let result = result else {
            return Fail(error: APIError.requestFailed(mesage: "NR: Request Failed")).eraseToAnyPublisher()
        }
        return result.map { $0 as? T}.eraseToAnyPublisher()
    }
}

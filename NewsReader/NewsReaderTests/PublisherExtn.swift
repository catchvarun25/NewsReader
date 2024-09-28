//
//  PublisherExtn.swift
//  NewsReaderTests
//
//  Created by Varun Mehta on 27/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import Combine

extension Publisher {
    /// Convert a Combine publisher into an async function that returns the first value.
    func firstValueAsync() async throws -> Output {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?
            cancellable = first() // As we only need the first value from the publisher
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        continuation.resume(throwing: error) // Resume with error if failure
                    case .finished:
                        break // Do nothing on completion
                    }
                }, receiveValue: { value in
                    continuation.resume(returning: value) // Resume with the value
                    cancellable?.cancel() // Cancel the subscription after receiving the value
                })
        }
    }
}


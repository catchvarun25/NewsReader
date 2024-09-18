//
//  CommonModels.swift
//  NewsReader
//
//  Created by Varun Mehta on 10/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import Foundation

enum ResponseType: String, Codable {
    case success
    case error
}

enum APIError: Error {
    case invalidRequest(message: String?)
    case networkFailure(message: String?)
    case requestFailed(mesage: String?)
    case parseFailure(message: String?)
    case other(message: String)
    
    static func map(_ error: Error) -> APIError {
        return (error as? APIError) ?? .other(message: error.localizedDescription)
    }
    
    var message: String? {
        switch self {
        case .invalidRequest(let message),
             .networkFailure(let message),
             .requestFailed(let message),
             .parseFailure(let message):
            return message
        case .other(let message):
            return message
        }
    }
}

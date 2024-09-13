//
//  EndpointService.swift
//  NewsReader
//
//  Created by Varun Mehta on 10/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import Foundation

struct API {
    static let scheme = "https"
    static let host = try? EnvConfig.value(EnvConfig.TARGET_HOST)
    static let api_key = try? EnvConfig.value(EnvConfig.API_KEY)
}

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]?

    var url: URL? {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}

// Article List Endpoints
extension Endpoint {
    static func topHeadLinesList(_ category: TopHeadlinesCategory, _ page: Int, _ pageSize: Int) -> Endpoint {
        return Endpoint(path: String(format: "/v2/top-headlines"), queryItems: [
            URLQueryItem(name: "category", value: category.rawValue),
            URLQueryItem(name: "apiKey", value: API.api_key),
            URLQueryItem(name: "pageSize", value: "\(pageSize)"),
            URLQueryItem(name: "page", value: "\(page)"),
        ])
    }
}

// Other Endpoints.....

//
//  TopHeadlinesService.swift
//  NewsReader
//
//  Created by Varun Mehta on 10/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import Foundation
import Combine

protocol TopHeadlinesServiceProtocol {
    func asyncGetTopHeadLinesFor(_ category: ArticleCategoryTypes, pageNumber: Int) -> AnyPublisher<ArticleListResp?, APIError>
}

extension TopHeadlinesServiceProtocol {
    func asyncGetTopHeadLines(_ pageNumber: Int) -> AnyPublisher<ArticleListResp?, APIError> {
        asyncGetTopHeadLinesFor(AppConstants.kDefaultSelectedCategory, pageNumber: pageNumber)
    }
}

class TopHeadlinesService: TopHeadlinesServiceProtocol {
    
    private let networkManager: Fetchable
    
    init(networkManager: Fetchable = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func asyncGetTopHeadLinesFor(_ category: ArticleCategoryTypes, pageNumber: Int) -> AnyPublisher<ArticleListResp?, APIError> {
        let endpoint = Endpoint.topHeadLinesList(category, pageNumber, Constants.kPageSize )
        return networkManager.fetch(with: endpoint)
    }
}

extension TopHeadlinesService {
    private enum Constants {
        static let kPageSize: Int = 20
    }
}

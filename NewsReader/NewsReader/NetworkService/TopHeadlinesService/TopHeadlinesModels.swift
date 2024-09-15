//
//  TopHeadlinesModels.swift
//  NewsReader
//
//  Created by Varun Mehta on 10/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import Foundation

enum ArticleCategoryTypes: String, CaseIterable {
    case all
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
}

enum TopHeadlinesStatus: String, Decodable {
    case success = "ok"
    case error = "error"
}


//MARK: Response Models -
struct ArticleListResp: Decodable {
    let status: TopHeadlinesStatus
    var code: String?
    var message: String?
    let totalResults: Int32?
    let articles: [ArticleResp]?
}

struct ArticleResp: Decodable {
    let source: ArticleSourceResp?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct ArticleSourceResp: Decodable {
    let id: String?
    let name: String?
}

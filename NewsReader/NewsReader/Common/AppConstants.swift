//
//  AppConstants.swift
//  NewsReader
//
//  Created by Varun Mehta on 11/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import Foundation

enum AppConstants {
    enum Cache {
        static let memoryCapacity: Int = 100 * 1024 * 1024 // 100MB
        static let diskCapacity: Int = 200 * 1024 * 1024 // 200MB
        static let path: String = "newsReader"
    }
    
    enum Error {
        static let kErrorMessage: String = "Failed to Load Page"
    }
    
    enum Network {
        static let kRequestTimeOut: Double = 5.0
    }
    
    enum PageTitle {
        static let kHome: String = "Top Headlines"
        static let kArticleDetail: String = "Detail Page"
        static let BookmarkArticles: String = "Bookmark Articles"
    }
    
    static let kDefaultSelectedCategory: ArticleCategoryTypes = .general
}

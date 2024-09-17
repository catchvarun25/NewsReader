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
    
    static let kDefaultSelectedCategory: ArticleCategoryTypes = .general
}

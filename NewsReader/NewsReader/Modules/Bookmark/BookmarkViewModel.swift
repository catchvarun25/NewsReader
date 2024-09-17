//
//  BookmarkViewModel.swift
//  NewsReader
//
//  Created by Varun Mehta on 17/9/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation
import Combine

protocol BookmarkViewModelProtocol {
    init( bookmarkManager: BookmarkManagerProtocol)
    func getBookmarkArticles() -> [ArticleDisplayModel]
}

class BookmarkViewModel: BookmarkViewModelProtocol {
    
    private let bookmarkManager: BookmarkManagerProtocol

     required init( bookmarkManager: BookmarkManagerProtocol = BookmarkManager.shared) {
        self.bookmarkManager = bookmarkManager
    }
    
    func getBookmarkArticles() -> [ArticleDisplayModel] {
        return bookmarkManager.getBookmarkedArticles()
    }
}

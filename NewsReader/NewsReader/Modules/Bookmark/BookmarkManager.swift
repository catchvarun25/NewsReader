//
//  BookmarkManager.swift
//  NewsReader
//
//  Created by Varun Mehta on 16/9/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation
import Combine

protocol BookmarkManagerProtocol {
    func getBookMarkedIds() -> Set<String>
    func getBookmarkedArticles() -> [ArticleDisplayModel]
    func addToBookmark(_ article: ArticleDisplayModel)
    func removeFromBookmark(_ article: ArticleDisplayModel)
    func removeAllBookmarks()
}

class BookmarkManager: BookmarkManagerProtocol {
    static let shared = BookmarkManager()
    private let defaults = UserDefaults.standard
    private init() {}
    
    func getBookMarkedIds() -> Set<String> {
        let array = getBookmarkedArticles().map {$0.id}
        return Set(array)
    }

    func getBookmarkedArticles() -> [ArticleDisplayModel] {
        if let data = defaults.data(forKey: UserDefaults.Keys.bookmarkedArticles),
           let articles = try? JSONDecoder().decode([ArticleDisplayModel].self, from: data) {
            return articles
        }
        return []
    }
    
    func addToBookmark(_ article: ArticleDisplayModel) {
        let updatedBookMarkedArticles = [article] + getBookmarkedArticles()
        if let data = try? JSONEncoder().encode(updatedBookMarkedArticles) {
            defaults.setValue(data, forKey: UserDefaults.Keys.bookmarkedArticles)
            defaults.synchronize()
        }
    }
    
    func removeFromBookmark(_ article: ArticleDisplayModel) {
        let existingArticles = getBookmarkedArticles()
        let updatedArticles = existingArticles.filter {$0.id != article.id}
        if let data = try? JSONEncoder().encode(updatedArticles) {
            defaults.setValue(data, forKey: UserDefaults.Keys.bookmarkedArticles)
            defaults.synchronize()
        }
    }
    
    func removeAllBookmarks() {
        defaults.removeObject(forKey: UserDefaults.Keys.bookmarkedArticles)
        defaults.synchronize()
    }
}

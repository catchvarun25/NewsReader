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
    var bookmarkListDataPublisher: Published<[ArticleDisplayModel]>.Publisher { get }

    init( bookmarkManager: BookmarkManagerProtocol)
    func getBookMarkList()
}

class BookmarkViewModel: BookmarkViewModelProtocol {
    //MARK: Private Accessors -
    @Published
    private var bookmarkListData: [ArticleDisplayModel] = []
    private let bookmarkManager: BookmarkManagerProtocol
    private var disposeBag = Set<AnyCancellable>()

    //MARK: Public Accessors -
    var bookmarkListDataPublisher: Published<[ArticleDisplayModel]>.Publisher { $bookmarkListData }

     required init( bookmarkManager: BookmarkManagerProtocol = BookmarkManager.shared) {
        self.bookmarkManager = bookmarkManager
        addBookmarkChangePublisher()
    }
    
    func getBookMarkList() {
        bookmarkListData = bookmarkManager.getBookmarkedArticles()
    }
    
    private func addBookmarkChangePublisher() {
        NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)
            .sink { [weak self] _ in
                self?.refetchBookmarkList()
            }
            .store(in: &disposeBag)
    }
    
    private func refetchBookmarkList() {
        bookmarkListData = bookmarkManager.getBookmarkedArticles()
    }
    
}

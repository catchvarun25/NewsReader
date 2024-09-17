//
//  ArticleDetailsViewModel.swift
//  NewsReader
//
//  Created by Varun Mehta on 17/9/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation
import Combine

protocol ArticleDetailsViewModelProtocol {
    var articleModelPublisher: Published<ArticleDisplayModel>.Publisher { get }
    
    init(articleModel: ArticleDisplayModel,
         bookmarkManager: BookmarkManagerProtocol)
    func didTapBookmarkItem()
}

class ArticleDetailsViewModel: ArticleDetailsViewModelProtocol {    
    //MARK: Private Accessors -
    private let bookmarkManager: BookmarkManagerProtocol
    @Published 
    private var articleModel: ArticleDisplayModel
    private var bookmarkCancellable: AnyCancellable?
    //MARK: Public Accessors -
    var articleModelPublisher: Published<ArticleDisplayModel>.Publisher { $articleModel }
    
    //MARK: LifeCycle Methods -
    required init(articleModel: ArticleDisplayModel,
                  bookmarkManager: BookmarkManagerProtocol = BookmarkManager.shared) {
        self.bookmarkManager = bookmarkManager
        self.articleModel = articleModel
    }
    
    //MARK: Public Methods -
    func didTapBookmarkItem() {
        articleModel.isBookmarked = !articleModel.isBookmarked
        if articleModel.isBookmarked {
            bookmarkManager.addToBookmark(articleModel)
        } else {
            bookmarkManager.removeFromBookmark(articleModel)
        }
    }
}

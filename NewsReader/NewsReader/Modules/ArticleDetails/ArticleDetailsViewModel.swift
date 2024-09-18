//
//  ArticleDetailsViewModel.swift
//  NewsReader
//
//  Created by Varun Mehta on 17/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
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
    //MARK: Public Accessors -
    var articleModelPublisher: Published<ArticleDisplayModel>.Publisher { $articleModel }

    //MARK: Private Accessors -
    @Published
    private var articleModel: ArticleDisplayModel
    private let bookmarkManager: BookmarkManagerProtocol
    private var bookmarkCancellable: AnyCancellable?
    private var bookmarkTapSubject = PassthroughSubject<Void, Never>()
    
    //MARK: LifeCycle Methods -
    required init(articleModel: ArticleDisplayModel,
                  bookmarkManager: BookmarkManagerProtocol = BookmarkManager.shared) {
        self.bookmarkManager = bookmarkManager
        self.articleModel = articleModel
        addBookmarkHandler()
    }
    
    //MARK: Public Methods -
    func didTapBookmarkItem() {
        bookmarkTapSubject.send()
    }
    
    private func addBookmarkHandler() {
        bookmarkCancellable = bookmarkTapSubject
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                articleModel.isBookmarked = !articleModel.isBookmarked
                if articleModel.isBookmarked {
                    bookmarkManager.addToBookmark(articleModel)
                } else {
                    bookmarkManager.removeFromBookmark(articleModel)
                }
            }
    }
}

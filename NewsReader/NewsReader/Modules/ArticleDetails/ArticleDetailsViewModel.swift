//
//  ArticleDetailsViewModel.swift
//  NewsReader
//
//  Created by Varun Mehta on 28/9/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation
import Combine

protocol ArticleDetailsViewModelProtocol: ObservableObject {
    var articleModel: ArticleDisplayModel { get }

    init(articleModel: ArticleDisplayModel,
         bookmarkManager: BookmarkManagerProtocol)
    func didTapBookmarkItem()
}

class ArticleDetailsViewModel: ArticleDetailsViewModelProtocol {

    //MARK: Private Accessors -
    @Published
    private(set) var articleModel: ArticleDisplayModel
    private let bookmarkManager: BookmarkManagerProtocol
    private var bookmarkCancellable: AnyCancellable?
    private var bookmarkTapSubject = PassthroughSubject<Void, Never>()
    
    //MARK: LifeCycle Methods -
    required init(articleModel: ArticleDisplayModel,
                  bookmarkManager: BookmarkManagerProtocol = BookmarkManager.shared) {
        self.bookmarkManager = bookmarkManager
        self.articleModel = articleModel
        bindPublisher()
    }
    
    //MARK: Public Methods -
    func didTapBookmarkItem() {
        bookmarkTapSubject.send()
    }
    
    private func bindPublisher() {
        bookmarkCancellable = bookmarkTapSubject
            .debounce(for: 0.2, scheduler: RunLoop.main)
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

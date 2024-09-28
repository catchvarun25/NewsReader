//
//  MockArticleListViewModel.swift
//  NewsReaderTests
//
//  Created by Varun Mehta on 27/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import Foundation
import Combine
@testable import NewsReader

class MockArticleListViewModel: ArticleListViewModelProtocol {
    //MARK: Public Accessors -
    var selectedCategory: ArticleCategoryTypes = AppConstants.kDefaultSelectedCategory

    //MARK: Private Accessors -
    private let service: TopHeadlinesServiceProtocol
    private let bookmarkManager: BookmarkManagerProtocol
    private var disposeBag = Set<AnyCancellable>()
    private var listData = [ArticleDisplayModel]()
    @Published
    private var fetchStatus: ArticleListFetchStatus = .none

    //MARK: Public Accessors -
    var fetchStatusPublisher: Published<ArticleListFetchStatus>.Publisher { $fetchStatus }
    

    required init(selectedCategory: ArticleCategoryTypes = AppConstants.kDefaultSelectedCategory,
         service: TopHeadlinesServiceProtocol = TopHeadlinesService(),
         bookmarkManager: BookmarkManagerProtocol = BookmarkManager.shared) {
        self.service = service
        self.bookmarkManager = bookmarkManager
        self.selectedCategory = selectedCategory
    }
    
    func fetchArticleList(_ page: Int) {
    }
    
    func onChangeSelectedCategory(_ type: NewsReader.ArticleCategoryTypes) {
        selectedCategory = type
    }
}

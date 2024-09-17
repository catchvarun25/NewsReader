//
//  ArticleListViewModel.swift
//  NewsReader
//
//  Created by Varun Mehta on 10/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import Foundation
import Combine

enum ArticleListFetchStatus {
    case loading
    case success(data: [ArticleDisplayModel])
    case failure(error: APIError)
    case reset
    case none
}
protocol ArticleListViewModelProtocol: NewsReaderCategoryChangeableProtocol {
    var fetchStatusPublisher: Published<ArticleListFetchStatus>.Publisher { get }
    
    init(selectedCategory: ArticleCategoryTypes,
         service: TopHeadlinesServiceProtocol,
         bookmarkManager: BookmarkManagerProtocol)
    func fetchArticleList(_ page: Int)
}

final class ArticleListViewModel: ArticleListViewModelProtocol {
        
    //MARK: Private Accessors -
    private let service: TopHeadlinesServiceProtocol
    private let bookmarkManager: BookmarkManagerProtocol
    private var disposeBag = Set<AnyCancellable>()
    private var selectedCategory: ArticleCategoryTypes = AppConstants.kDefaultSelectedCategory
    private var listData = [ArticleDisplayModel]()

    @Published private var fetchStatus: ArticleListFetchStatus = .none

    //MARK: Public Accessors -
    var fetchStatusPublisher: Published<ArticleListFetchStatus>.Publisher { $fetchStatus }
    
    init(selectedCategory: ArticleCategoryTypes = AppConstants.kDefaultSelectedCategory,
         service: TopHeadlinesServiceProtocol = TopHeadlinesService(),
         bookmarkManager: BookmarkManagerProtocol = BookmarkManager.shared) {
        self.service = service
        self.bookmarkManager = bookmarkManager
        self.selectedCategory = selectedCategory
    }
    
    //MARK: Public Methods -
    func fetchArticleList(_ page: Int) {
        if page == 1 {
            fetchStatus = .loading
            self.listData = []
        }
        service.asyncGetTopHeadLinesFor(selectedCategory, pageNumber: page)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("VARUN: Error At ViewModel: \(error.localizedDescription)")
                    self?.fetchStatus = .failure(error: .map(error))
                }
            }, receiveValue: { [weak self] data in
                guard let self = self, let responseData = data, let articles = responseData.articles else { return }
                let bookMarkedIds = self.bookmarkManager.getBookMarkedIds()
                let articleDisplayModels = articles.compactMap { (respModel) in
                    if var displayModel = ArticleDisplayModel(respModel) {
                        displayModel.isBookmarked = bookMarkedIds.contains(displayModel.id)
                        return displayModel
                    }
                    return nil
                }
                self.listData = self.listData + articleDisplayModels
                self.fetchStatus = .success(data: self.listData)
            })
            .store(in: &disposeBag)
    }    
}

extension ArticleListViewModel {
    func onChangeSelectedCategory(_ type: ArticleCategoryTypes) {
        selectedCategory = type
        fetchStatus = .reset
    }
}

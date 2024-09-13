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
    case none
}

protocol ArticleListViewModelProtocol {
    var fetchStatusPublisher: Published<ArticleListFetchStatus>.Publisher { get }
    
    init(service: TopHeadlinesServiceProtocol)
    func fetchArticleList(_ page: Int)
}

final class ArticleListViewModel: ArticleListViewModelProtocol {
        
    //MARK: Private Accessors -
    private let service: TopHeadlinesServiceProtocol
    private var disposeBag = Set<AnyCancellable>()

    @Published private var fetchStatus: ArticleListFetchStatus = .none

    //MARK: Public Accessors -
    var fetchStatusPublisher: Published<ArticleListFetchStatus>.Publisher { $fetchStatus }
    
    init(service: TopHeadlinesServiceProtocol = TopHeadlinesService()) {
        self.service = service
    }
    
    //MARK: Public Methods -
    func fetchArticleList(_ page: Int) {
        fetchStatus = .loading
        service.asyncGetTopHeadLines(page)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("VARUN: Error At ViewModel: \(error.localizedDescription)")
                    self?.fetchStatus = .failure(error: .map(error))
                }
            }, receiveValue: { [weak self] data in
                guard let responseData = data, let articles = responseData.articles else { return }
                self?.fetchStatus = .success(data: articles.map{ ArticleDisplayModel($0) })
            })
            .store(in: &disposeBag)
    }
    
}

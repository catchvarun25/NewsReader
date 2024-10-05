//
//  ArticleListViewModelTests.swift
//  NewsReaderTests
//
//  Created by Varun Mehta on 27/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import XCTest
import Combine

@testable import NewsReader

class ArticleListViewModelTests: XCTestCase {
    var subject: ArticleListViewModel!
    var mockNetworkManager: MockNetworkManager!
    private var disposeBag = Set<AnyCancellable>()

    override func setUp() {
        mockNetworkManager = MockNetworkManager()
        subject = ArticleListViewModel(selectedCategory: ArticleCategoryTypes.entertainment,
                                       service: TopHeadlinesService(networkManager: mockNetworkManager))
        super.setUp()
    }
    
    override func tearDown() {
        subject = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testFetchArticleListSuccess() {
        //Given...
        let expectation = expectation(description: "Expectation to get ArticleList data.")
        let successResponse = try? JSONReader.readJSON(forResource: "TopHeadlines_Entertainment_Success", as: ArticleListResp.self)
        mockNetworkManager.result = Just(successResponse as Any).setFailureType(to: APIError.self).eraseToAnyPublisher()
        
        //When...
        subject.fetchArticleList(Constants.kSuccessPageNumber)
        subject.fetchStatusPublisher.sink { status in
            switch status {
            case .success(let articleList):
                XCTAssertTrue(articleList.count == AppConstants.kDefaultPageSize)
                XCTAssertTrue(articleList[0].title == Constants.kTitleFirstArticle)
                expectation.fulfill()
            default:
                debugPrint("NR: fetchArticleList Status: \(status)")
            }
        }
        .store(in: &disposeBag)
        
        //Then..
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchArticleListFailure() {
        //Given...
        let expectation = expectation(description: "Expectation to get ArticleList data.")
        
        //When..
        subject.fetchArticleList(Constants.kFailPageNumber)
        subject.fetchStatusPublisher.sink { status in
            switch status {
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            default:
                debugPrint("NR: fetchArticleList Status: \(status)")
            }
        }
        .store(in: &disposeBag)
        
        //Then..
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testOnChangeSelectedCategory() {
        
        //Given..
        let expectation = expectation(description: "Expectation on changing category")
        
        //When..
        subject.onChangeSelectedCategory(ArticleCategoryTypes.science)
        
        //Then..
        subject.fetchStatusPublisher.sink { status in
            switch status {
            case .reset:
                expectation.fulfill()
            default:
                debugPrint("NR: fetchArticleList Status: \(status)")
            }
        }
        .store(in: &disposeBag)
        
        wait(for: [expectation], timeout: 1.0)

    }

}

extension ArticleListViewModelTests {
    private enum Constants {
        static let kSuccessPageNumber = 1
        static let kFailPageNumber = 2
        static let kTitleFirstArticle = "Janel Grant’s attorney: Netflix doc doesn’t tell full story of Vince’s crimes - Cageside Seats"
    }
}

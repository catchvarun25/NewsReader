//
//  Copyright © 2024 NewsReader. All rights reserved.
//

import XCTest
import Combine

@testable import NewsReader

class HomeViewModelTests: XCTestCase {
    var subject: HomeViewModel!
    private var disposeBag = Set<AnyCancellable>()
    private var mockArticleListViewModel:MockArticleListViewModel!
    override func setUp() {
        super.setUp()
        mockArticleListViewModel = MockArticleListViewModel()
        subject = HomeViewModel(mockArticleListViewModel)
    }
    
    override func tearDown() {
        subject = nil
        mockArticleListViewModel = nil
        super.tearDown()
    }

    func testfillCategoriesData() throws {
        
        //Given..
        let expectation = XCTestExpectation(description: "Expectation to fill categories data")
        
        //When..
        subject.$categoriesData
            .sink { categoriesData in
                if categoriesData.count > 0 {
                    //Then..
                    XCTAssertEqual(categoriesData.count, ArticleCategoryTypes.allCases.count, "Categories should be loaded before Home Page")
                    let selectedCategory = categoriesData.first { $0.isSelected }
                    XCTAssertEqual(selectedCategory?.type, AppConstants.kDefaultSelectedCategory, "The default selected category is NOT correct.")
                    expectation.fulfill()
                }
            }.store(in: &disposeBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testOnChangeSelectedCategory() {
        // Given
        let initialSelectedCategory = AppConstants.kDefaultSelectedCategory
        let newSelectedCategory = ArticleCategoryTypes.health
        
        let expectation = XCTestExpectation(description: "Selected category should be updated")
        
        subject.$categoriesData
            .dropFirst()
            .sink { categories in
                let selectedCategory = categories.first { $0.isSelected }
                XCTAssertEqual(selectedCategory?.type, newSelectedCategory, "Selected category should be updated to the new one")
                expectation.fulfill()
            }
            .store(in: &disposeBag)
        
        // When
        subject.onChangeSelectedCategory(newSelectedCategory)
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(mockArticleListViewModel.selectedCategory, newSelectedCategory, "Selected category should be updated to the ArticleListViewModel")
    }

    
}

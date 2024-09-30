//
//  NewsReaderHomeViewModel.swift
//  NewsReader
//
//  Created by Varun Mehta on 13/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import Foundation

struct CategoryTypeDisplayModel: Identifiable {
    var id: String
    let name: String
    let type: ArticleCategoryTypes
    var isSelected: Bool = false
}

protocol NewsReaderCategoryChangeableProtocol {
    func onChangeSelectedCategory(_ type: ArticleCategoryTypes)
}

protocol NewsReaderHomeViewModelProtocol: NewsReaderCategoryChangeableProtocol, ObservableObject {
    var categoriesData: [CategoryTypeDisplayModel] { get }
    func getArticleListViewModel() -> ArticleListViewModelProtocol
}


class NewsReaderHomeViewModel: NewsReaderHomeViewModelProtocol  {
    
    @Published
    private(set) var categoriesData:[CategoryTypeDisplayModel] = []
    private let articleListViewModel: ArticleListViewModelProtocol
    
    init(_ articleListViewModel: ArticleListViewModelProtocol = ArticleListViewModel()) {
        self.articleListViewModel = articleListViewModel
        fillCategoriesData()
    }
    
    func getArticleListViewModel() -> ArticleListViewModelProtocol {
        return articleListViewModel
    }

    private func fillCategoriesData() {
        if categoriesData.count > 0 {
            return
        }
        var tempCategories: [CategoryTypeDisplayModel] = []
        for categoryType in ArticleCategoryTypes.allCases {
            var categoryDisplayModel = CategoryTypeDisplayModel(id: categoryType.rawValue,
                                                                name: categoryType.rawValue.capitalized,
                                                                type: categoryType)
            categoryDisplayModel.isSelected = categoryType == AppConstants.kDefaultSelectedCategory
            tempCategories.append(categoryDisplayModel)
        }
        categoriesData.append(contentsOf: tempCategories)
    }
    
}

extension NewsReaderHomeViewModel : NewsReaderCategoryChangeableProtocol{
    func onChangeSelectedCategory(_ type: ArticleCategoryTypes) {
        categoriesData = categoriesData.map { model in
            var updatedModel = model
            updatedModel.isSelected = updatedModel.type == type
            return updatedModel
        }
        articleListViewModel.onChangeSelectedCategory(type)
    }
}

//
//  NewsReaderHomeViewModel.swift
//  NewsReader
//
//  Created by Varun Mehta on 13/9/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

struct CategoryTypeDisplayModel {
    let name: String
    let type: ArticleCategoryTypes
    var isSelected: Bool = false
}

protocol NewsReaderCategoryChangeableProtocol {
    func onChangeSelectedCategory(_ type: ArticleCategoryTypes)
}

protocol NewsReaderHomeViewModelProtocol: NewsReaderCategoryChangeableProtocol {
    var categoriesData: Published<[CategoryTypeDisplayModel]>.Publisher { get }
    func getArticleListViewModel() -> ArticleListViewModelProtocol
}


class NewsReaderHomeViewModel: NewsReaderHomeViewModelProtocol  {
    
    var categoriesData:Published<[CategoryTypeDisplayModel]>.Publisher { $categoriesDataPublisher }
    private let articleListViewModel: ArticleListViewModelProtocol
    @Published
    private var categoriesDataPublisher: [CategoryTypeDisplayModel] = []
    
    init(_ articleListViewModel: ArticleListViewModelProtocol = ArticleListViewModel()) {
        self.articleListViewModel = ArticleListViewModel()
        fillCategoriesData()
    }
    
    func getArticleListViewModel() -> ArticleListViewModelProtocol {
        return articleListViewModel
    }

    private func fillCategoriesData() {
        if categoriesDataPublisher.count > 0 {
            return
        }
        var tempCategories: [CategoryTypeDisplayModel] = []
        for categoryType in ArticleCategoryTypes.allCases {
            var categoryDisplayModel = CategoryTypeDisplayModel(name: categoryType.rawValue, type: categoryType)
            categoryDisplayModel.isSelected = categoryType == AppConstants.kDefaultSelectedCategory
            tempCategories.append(categoryDisplayModel)
        }
        categoriesDataPublisher.append(contentsOf: tempCategories)
    }
    
}

extension NewsReaderHomeViewModel : NewsReaderCategoryChangeableProtocol{
    func onChangeSelectedCategory(_ type: ArticleCategoryTypes) {
        categoriesDataPublisher = categoriesDataPublisher.map { model in
            var updatedModel = model
            updatedModel.isSelected = updatedModel.type == type
            return updatedModel
        }
        articleListViewModel.onChangeSelectedCategory(type)
    }
}

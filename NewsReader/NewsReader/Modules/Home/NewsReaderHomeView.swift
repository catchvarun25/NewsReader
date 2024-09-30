//
//  NewsReaderHomeView.swift
//  NewsReader
//
//  Created by Varun Mehta on 28/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import SwiftUI

struct NewsReaderHomeView<ViewModel: NewsReaderHomeViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    @State var navigateToBookMark: Bool = false
    init(viewModel: ViewModel = NewsReaderHomeViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        NavigationView {
            VStack {
                CategoriesGridView(viewModel: viewModel)
                    .frame(height: Constants.kHeightCategoryList)
                ArticleListHoistingView(viewModel: viewModel.getArticleListViewModel())
                NavigationLink(
                    destination: BookMarkHoistingView(),
                    isActive: $navigateToBookMark,
                    label: {
                        EmptyView()
                    }
                )
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle(AppConstants.PageTitle.kHome)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NRSButton(leftIcon: "bookmark",
                              tintColor: .redNR) {
                        navigateToBookMark = true
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

extension NewsReaderHomeView {
    private enum Constants {
        static var kHeightCategoryList: CGFloat {
            return 44.0
        }
    }
}

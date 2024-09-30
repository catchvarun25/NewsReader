//
//  ArticleDetailsView.swift
//  NewsReader
//
//  Created by Varun Mehta on 28/9/24.
//  Copyright © 2024 Target. All rights reserved.
//

import SwiftUI
import WebKit

struct ArticleDetailsView<ViewModel: ArticleDetailsViewModelProtocol>: View {
    @StateObject
    private var viewModel: ViewModel
    @State 
    private var isLoading: Bool = true
    @Environment(\.presentationMode) var presentationMode
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                NRSWebView(isLoading: $isLoading, urlString: viewModel.articleModel.articleURL)
                    .showLoader($isLoading)
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle(viewModel.articleModel.source ?? AppConstants.PageTitle.kArticleDetail)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NRSButton(leftIcon: viewModel.articleModel.isBookmarked ? "bookmark.fill" : "bookmark",
                              tintColor: .redNR) {
                        viewModel.didTapBookmarkItem()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    NRSButton(leftIcon: "chevron.left",
                              tintColor: .redNR) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

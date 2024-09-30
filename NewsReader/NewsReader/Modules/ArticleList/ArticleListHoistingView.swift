//
//  ArticleListHoistingView.swift
//  NewsReader
//
//  Created by Varun Mehta on 29/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import SwiftUI

struct ArticleListHoistingView: UIViewControllerRepresentable {
    let viewModel: ArticleListViewModelProtocol
    init(viewModel: any ArticleListViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func makeUIViewController(context: Context) -> ArticleListViewController {
        let articleListViewController = ArticleListViewController(viewModel: viewModel)
        return articleListViewController
    }
    
    func updateUIViewController(_ uiViewController: ArticleListViewController, context: Context) {
        
    }
    
}

//
//  CategoryGridView.swift
//  NewsReader
//
//  Created by Varun Mehta on 29/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import SwiftUI

struct CategoriesGridView<ViewModel: NewsReaderHomeViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var rows: [GridItem] = [
        GridItem(.flexible(minimum: 44.0)),
    ]
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, spacing: 0.0) {
                        ForEach(viewModel.categoriesData) { categoryModel in
                            CategoryItemView(data: categoryModel)
                            .onTapGesture {
                                viewModel.onChangeSelectedCategory(categoryModel.type)
                            }
                        }
                    }
                }
                .frame(height: geometry.size.height)
                .background(Color.white)
            }
        }
    }
}


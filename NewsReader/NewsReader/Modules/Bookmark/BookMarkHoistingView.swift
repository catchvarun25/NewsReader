//
//  BookMarkHoistingView.swift
//  NewsReader
//
//  Created by Varun Mehta on 30/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import SwiftUI

struct BookMarkHoistingView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> BookmarkViewController {
        let controller = BookmarkViewController(viewModel: BookmarkViewModel())
        return controller
    }
    
    func updateUIViewController(_ uiViewController: BookmarkViewController, context: Context) {

    }
}

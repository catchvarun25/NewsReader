//
//  NRSWebView.swift
//  NewsReader
//
//  Created by Varun Mehta on 28/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import SwiftUI
import WebKit

struct NRSWebView: UIViewRepresentable {
    @Binding var isLoading: Bool
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero)
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func makeCoordinator() -> NRWebViewCoordinator {
        NRWebViewCoordinator(parent: self)
    }
}

class NRWebViewCoordinator: NSObject, WKNavigationDelegate {
    let parent: NRSWebView
    init(parent: NRSWebView) {
        self.parent = parent
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        parent.isLoading = true
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        parent.isLoading = false
    }
        
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        parent.isLoading = false
    }

}

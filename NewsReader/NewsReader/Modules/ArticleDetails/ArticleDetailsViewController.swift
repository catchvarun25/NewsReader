//
//  ArticleDetailsViewController.swift
//  NewsReader
//
//  Created by Varun Mehta on 15/9/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit
import SnapKit
import WebKit

class ArticleDetailsViewController: UIViewController {
    //MARK: Private Accessor
    private let articleDetailsURL: String
    private let articleSource: String
    private lazy var articleDetailsView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.navigationDelegate = self
        return webView
    }()
            
    init(articleURL: String, source: String) {
        self.articleDetailsURL = articleURL
        self.articleSource = source
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = articleSource
        navigationController?.setNavigationBar(type: .whiteWithBottomBorder)
    }
    
    //MARK: Private Methods
    private func setupUI() {
        //CategoryList
        self.view.addSubview(articleDetailsView)
        articleDetailsView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
    
    private func loadPage() {
        if let url = URL(string: articleDetailsURL) {
            let request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData)
            articleDetailsView.load(request)
        }
    }
}

extension ArticleDetailsViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showLoader()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        self.hideLoader()
    }
        
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        self.hideLoader()
    }
}

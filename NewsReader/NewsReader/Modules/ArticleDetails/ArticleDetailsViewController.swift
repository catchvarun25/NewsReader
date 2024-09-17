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
import Combine

class ArticleDetailsViewController: UIViewController {
    //MARK: Private Accessor
    private let viewModel: ArticleDetailsViewModelProtocol
    private var articleModel: ArticleDisplayModel {
        didSet {
            updateBookMarkIcon()
        }
    }
    private var disposeBag = Set<AnyCancellable>()
    private lazy var articleDetailsView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.navigationDelegate = self
        return webView
    }()
    
    private lazy var bookmarkButton: UIBarButtonItem = {
        let barItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(bookmarkTapped))
        barItem.tintColor = .redNR
        return barItem
    }()

    init(articleModel: ArticleDisplayModel) {
        self.articleModel = articleModel
        self.viewModel = ArticleDetailsViewModel(articleModel: articleModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadPage()
        bindPublisher()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //TODO: Handle With Localisation
        self.title = articleModel.source ?? "Detail Page"
        navigationController?.setNavigationBar(type: .whiteWithBottomBorder)
    }
    
    //MARK: Private Methods
    private func setupUI() {
        updateBookMarkIcon()
        //CategoryList
        self.view.addSubview(articleDetailsView)
        articleDetailsView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
    private func bindPublisher() {
        viewModel.articleModelPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self = self else { return }
                self.articleModel = model
            }
            .store(in: &disposeBag)
    }

    
    private func updateBookMarkIcon() {
        print("VARUN: Calling updateBookMarkIcon.....")
        let imageName = articleModel.isBookmarked ? "bookmark.fill" : "bookmark"
        let barItem = UIBarButtonItem(image: UIImage(systemName: imageName),
                                      style: .plain,
                                      target: self,
                                      action: #selector(bookmarkTapped))
        barItem.tintColor = .redNR
        navigationItem.setRightBarButtonItems([barItem], animated: true)
    }
    
    private func loadPage() {
        if let url = URL(string: articleModel.articleURL) {
            let request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData)
            articleDetailsView.load(request)
        }
    }
    
    @objc
    private func bookmarkTapped() {
        viewModel.didTapBookmarkItem()
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

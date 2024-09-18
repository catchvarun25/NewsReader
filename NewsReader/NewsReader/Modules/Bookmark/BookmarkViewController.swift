//
//  BookmarkViewController.swift
//  NewsReader
//
//  Created by Varun Mehta on 16/9/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit
import SnapKit

class BookmarkViewController: UIViewController {
    //MARK: Private Accessor
    private let viewModel: BookmarkViewModelProtocol
    private var articleListData: [ArticleDisplayModel] = []
    
    private let verticalLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.screenWidth, height: Constants.kCellHeight)
        layout.minimumLineSpacing = 0.0
        return layout
    }()

    private lazy var articleListView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout:verticalLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(cellType: ArticleListCell.self)
        return collectionView
    }()

        
    init(viewModel: BookmarkViewModelProtocol = BookmarkViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        articleListData = viewModel.getBookmarkArticles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = AppConstants.PageTitle.BookmarkArticles
        navigationController?.setNavigationBar(type: .whiteWithBottomBorder)
    }
    
    
    //MARK: Private Methods
    private func setupUI() {
        //ArticleList
        view.addSubview(articleListView)
        articleListView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension BookmarkViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return articleListData.count
    }
        
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: ArticleListCell.self, at: indexPath)
        if let cellData = articleListData[safe: indexPath.row] {
            cell.configureView(data: cellData, showDivider: indexPath.row != articleListData.count - 1)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cellData = articleListData[safe: indexPath.row] {
            let detailViewController = ArticleDetailsViewController(articleModel: cellData)
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

extension BookmarkViewController {
    private enum Constants {
        static let kCellHeight: CGFloat = 175.0
    }
}


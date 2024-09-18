//
//  NewsReaderHomeViewController.swift
//  NewsReader
//
//  Created by Varun Mehta on 13/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit
import SnapKit
import Combine

class NewsReaderHomeViewController: UIViewController {
    //MARK: Private Accessor
    private let viewModel: NewsReaderHomeViewModelProtocol
    private var disposeBag = Set<AnyCancellable>()
    private let horizontalLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120.0, height: 44.0)
        layout.minimumLineSpacing = 0.0
        return layout
    }()

    private lazy var categoryListView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout:horizontalLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(cellType: CategoryListItemCell.self)
        return collectionView
    }()
    
    private lazy var bookmarkButton: UIBarButtonItem = {
        let barItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(bookmarkTapped))
        barItem.tintColor = .textBlackNR
        return barItem
    }()
    
    private var categoryListData: [CategoryTypeDisplayModel] = []
    
    //MARK: Lifecycle Methods
    init(viewModel: NewsReaderHomeViewModelProtocol = NewsReaderHomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bindPublishers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = AppConstants.PageTitle.kHome
        navigationController?.setNavigationBar(type: .whiteWithBottomBorder)
    }
    
    
    //MARK: Private Methods - 
    private func setupUI() {
        navigationItem.rightBarButtonItem = bookmarkButton

        //CategoryList
        self.view.addSubview(categoryListView)
        categoryListView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(Constants.kHeightCategoryList)
        }
        //ArticleList
        let articleListController = ArticleListViewController(viewModel: viewModel.getArticleListViewModel())
        self.add(articleListController, frame: .zero)
        articleListController.view.snp.makeConstraints { make in
            make.top.equalTo(categoryListView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func bindPublishers() {
        viewModel.categoriesData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] categoriesData in
                self?.categoryListData = categoriesData
                self?.categoryListView.reloadData()
            }.store(in: &disposeBag)
    }
    
    @objc 
    private func bookmarkTapped() {
        let bookmarkController = BookmarkViewController()
        self.navigationController?.pushViewController(bookmarkController, animated: true)
    }
}

extension NewsReaderHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return categoryListData.count
    }
        
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: CategoryListItemCell.self, at: indexPath)
        if let cellData = categoryListData[safe: indexPath.row] {
            cell.configureView(cellData)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cellData = categoryListData[safe: indexPath.row] {
            viewModel.onChangeSelectedCategory(cellData.type)
        }
    }
}

extension NewsReaderHomeViewController {
    private enum Constants {
        static let kHeightCategoryList: CGFloat = 44.0
    }
}

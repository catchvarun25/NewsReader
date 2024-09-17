//
//  ArticleListViewController.swift
//  NewsReader
//
//  Created by Varun Mehta on 12/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit
import Combine
import SnapKit

final class ArticleListViewController: NRPageCollectionViewController {
    //MARK: Private Accessors -
    private let viewModel: ArticleListViewModelProtocol
    private var disposeBag = Set<AnyCancellable>()
    private var listData = [ArticleDisplayModel]()
    
    private let verticalLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.screenWidth, height: Constants.kCellHeight)
        layout.minimumLineSpacing = 0.0
        return layout
    }()
        
    //MARK: LifeCycle Methods -
    init(viewModel: ArticleListViewModelProtocol = ArticleListViewModel()) {
        self.viewModel = viewModel
        super.init(layout: verticalLayout, apiSource: viewModel.fetchArticleList)
        bindPublishers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startLoading()
    }
    
    override func setupCollection() {
        super.setupCollection()
        self.collectionView.register(cellType: ArticleListCell.self)
    }
        
    //MARK: Private Methods -
    private func bindPublishers() {
        viewModel.fetchStatusPublisher
            .receive(on: DispatchQueue.main, options: nil)
            .sink { [weak self] fetchStatus in
                switch fetchStatus {
                case .loading:
                    self?.hideError()
                    self?.showLoader()
                case .success(let listData):
                    self?.hideLoader()
                    self?.listData = listData
                    self?.collectionView.reloadData()
                case .failure(let error):
                    self?.hideLoader()
                    self?.showError(message: error.message, handler: {
                        self?.listData = []
                        self?.reloadContent()
                    })
                case .reset:
                    self?.listData = []
                    self?.collectionView.reloadData()
                    self?.reloadContent()
                case .none:
                    debugPrint("")
                }
            }
            .store(in: &disposeBag)
    }
}


extension ArticleListViewController {
    override func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return listData.count
    }
        
    override func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: ArticleListCell.self, at: indexPath)
        if let cellData = listData[safe: indexPath.row] {
            let showDivider = indexPath.row != listData.count - 1
            cell.configureView(data: cellData, showDivider: showDivider)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cellData = listData[safe: indexPath.row] {
            let detailViewController = ArticleDetailsViewController(articleModel: cellData)
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
extension ArticleListViewController {
    private enum Constants {
        static let kCellHeight: CGFloat = 175.0
    }
}


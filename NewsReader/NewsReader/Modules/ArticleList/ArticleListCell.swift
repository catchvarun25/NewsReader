//
//  ArticleListCell.swift
//  NewsReader
//
//  Created by Varun Mehta on 12/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit

final class ArticleListCell: UICollectionViewCell {
    
    //MARK: Private Accessors -
    private lazy var listItemView = NRArticleShortView()
    private lazy var bookMarkButton: NRButton = {
        let button = NRButton(iconName: Constants.kBookmarkIconName, backgroundColor: .clear)
        button.tintColor = .redNR
        return button
    }()
    private let divider = NRDividerView()
    
    //MARK: Lifecycle Methods -
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public Methods -
    func configureView(data: ArticleDisplayModel, showDivider: Bool = true) {
        listItemView.configureView(data: data)
        divider.isHidden = !showDivider
        updateIfBookMarked(data)
    }
    
    //MARK: Private Methods -
    private func setupUI() {
        addSubview(listItemView)
        addSubview(divider)

        setupConstraints()
    }
    
    private func setupConstraints() {
        listItemView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(Constants.kCellInset)
        }
        
        
        divider.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(Constants.kCellInset)
            make.trailing.equalToSuperview()
        }
    }
    
    private func updateIfBookMarked(_ data: ArticleDisplayModel) {
        if data.isBookmarked {
            addSubview(bookMarkButton)
            bookMarkButton.snp.makeConstraints { make in
                make.height.width.equalTo(24.0)
                make.top.equalToSuperview()
                make.trailing.equalToSuperview()
            }
        } else {
            bookMarkButton.safeRemoveFromSuperView()
        }
    }
}

extension ArticleListCell {
    private enum Constants {
        static let kCellInset: CGFloat = 16.0
        static let kBookmarkIconName = "bookmark.fill"
    }
}

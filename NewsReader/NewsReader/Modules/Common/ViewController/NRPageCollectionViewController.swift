//
//  NRPageCollectionViewController.swift
//  NewsReader
//
//  Created by Varun Mehta on 10/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import Foundation
import UIKit

typealias APISource = ((Int) -> Void)

class NRPageCollectionViewController: UICollectionViewController {
    
    private var initialContentOffsetY: CGFloat?
    private var sourcePageNumber: Int = Constants.kStartPageNumber
    private var prevPageCount: Int = 0
    
    //Use to call for the next set of result.
    private let apiSource: APISource?
    
    init(layout: UICollectionViewFlowLayout, apiSource: @escaping APISource) {
        self.apiSource = apiSource
        super.init(collectionViewLayout: layout)
        setupCollection()
    }
    
    init(apiSource: @escaping APISource) {
        self.apiSource = apiSource
        super.init()
        setupCollection()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.frame.size.height
        let contentHeight = scrollView.contentSize.height
        guard scrollViewHeight > 0, contentHeight > 0 else { return }
        
        let currentYOffset = scrollView.contentOffset.y
        let pageCount = Int(contentHeight / scrollViewHeight)
        let pageNumber = Int((currentYOffset + abs(initialContentOffsetY ?? 0.0)) / scrollViewHeight)
        if  pageNumber == pageCount - 1 && pageCount > prevPageCount {
                prevPageCount = pageCount
                loadMoreData()
        }
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let currentYOffset = scrollView.contentOffset.y
        if initialContentOffsetY == nil {
            initialContentOffsetY = currentYOffset
        }
    }
    
    func startLoading() {
        sourcePageNumber = Constants.kStartPageNumber
        apiSource?(sourcePageNumber)
    }
    
    func reloadContent() {
        resetData()
        apiSource?(sourcePageNumber)
    }
    
    func setupCollection() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func resetData() {
        prevPageCount = 0
        sourcePageNumber = Constants.kStartPageNumber
    }
    
    private func loadMoreData() {
        sourcePageNumber += 1
        apiSource?(sourcePageNumber)
    }

}

extension NRPageCollectionViewController {
    private enum Constants {
        static let kStartPageNumber: Int = 1
        static let kContentOffsetBuffer: CGFloat = 100.0
    }
}

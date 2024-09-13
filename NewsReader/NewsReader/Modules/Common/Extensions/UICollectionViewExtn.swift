//
//  UICollectionViewExtn.swift
//  NewsReader
//
//  Created by Varun Mehta on 13/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    /// Registers a cell class for use in creating new collection view cells.
    ///
    /// - Parameter cellType: The class of a cell that you want to use in the collection view.
    func register<T: UICollectionViewCell>(cellType: T.Type) {
        self.register(cellType, forCellWithReuseIdentifier: String(describing: cellType))
    }
    
    /// Registers a reusable view class for use in creating supplementary views for the collection view.
    ///
    /// - Parameter viewType: The class of a reusable view that you want to use in the collection view.
    /// - Parameter elementKind: The kind of supplementary view to create.
    func register<T: UICollectionReusableView>(viewType: T.Type, forSupplementaryViewOfKind elementKind: String) {
        self.register(viewType, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: String(describing: viewType))
    }
    
    /// Dequeues a reusable cell for the specified reuse identifier and type.
    ///
    /// - Parameters:
    ///   - cellType: The class of the cell you want to dequeue.
    ///   - indexPath: The index path specifying the location of the cell.
    /// - Returns: A valid UICollectionViewCell object.
    func dequeueReusableCell<T: UICollectionViewCell>(for cellType: T.Type, at indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: String(describing: cellType), for: indexPath) as? T else {
            fatalError("Error: cell with identifier: \(String(describing: cellType)) could not be dequeued")
        }
        return cell
    }
    
    /// Dequeues a reusable supplementary view for the specified reuse identifier and type.
    ///
    /// - Parameters:
    ///   - viewType: The class of the reusable view you want to dequeue.
    ///   - elementKind: The kind of supplementary view to create.
    ///   - indexPath: The index path specifying the location of the supplementary view.
    /// - Returns: A valid UICollectionReusableView object.
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(for viewType: T.Type, ofKind elementKind: String, at indexPath: IndexPath) -> T {
        guard let view = self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: String(describing: viewType), for: indexPath) as? T else {
            fatalError("Error: view with identifier: \(String(describing: viewType)) could not be dequeued")
        }
        return view
    }
}

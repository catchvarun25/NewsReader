//
//  CategoryListItemCell.swift
//  NewsReader
//
//  Created by Varun Mehta on 14/9/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit

final class CategoryListItemCell: UICollectionViewCell {
    
    //MARK: Private Accessors -
    private let titleLabel: NRLabel = {
        let label = NRLabel(font: .smallBold, color: .grayDarkestNR)
        label.textInsets = .all(6.0)
        label.numberOfLines = 0
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }
    
    func configureView(_ data: CategoryTypeDisplayModel) {
        titleLabel.text = data.name.uppercased()
        titleLabel.backgroundColor = data.isSelected ? .redNR : .grayLightNR
    }
}
